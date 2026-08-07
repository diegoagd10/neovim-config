local M = {}

local formatted_filetypes = {
  javascript = "biome",
  javascriptreact = "biome",
  typescript = "biome",
  typescriptreact = "biome",
  python = "ruff",
}

local function telescope(name, opts)
  require("telescope.builtin")[name](opts or {})
end

local function analysis_client(bufnr)
  local filetype = vim.bo[bufnr].filetype
  local preferred = filetype == "python" and "pyright" or "ts_ls"

  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if client.name == preferred then
      return client
    end
  end
end

local function show_location_picker(bufnr, method, title)
  local client = analysis_client(bufnr)
  if not client then
    vim.notify("No analysis language server is attached", vim.log.levels.INFO)
    return
  end

  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  if method == "textDocument/references" then
    params.context = { includeDeclaration = true }
  end

  client:request(method, params, function(err, result)
    if err then
      vim.notify(("%s: %s"):format(title, err.message), vim.log.levels.WARN)
      return
    end

    if result == nil then
      vim.notify(("%s: no results"):format(title), vim.log.levels.INFO)
      return
    end

    local locations = vim.islist(result) and result or { result }
    local items = vim.lsp.util.locations_to_items(locations, client.offset_encoding)
    if #items == 0 then
      vim.notify(("%s: no results"):format(title), vim.log.levels.INFO)
      return
    end

    local opts = {
      prompt_title = title,
      reuse_win = true,
    }
    local telescope_pickers = require("telescope.pickers")
    local telescope_finders = require("telescope.finders")
    local telescope_config = require("telescope.config").values
    local telescope_entry = require("telescope.make_entry")

    telescope_pickers
      .new(opts, {
        finder = telescope_finders.new_table({
          results = items,
          entry_maker = telescope_entry.gen_from_quickfix(opts),
        }),
        previewer = telescope_config.qflist_previewer(opts),
        sorter = telescope_config.generic_sorter(opts),
        push_cursor_on_edit = true,
        push_tagstack_on_edit = true,
      })
      :find()
  end, bufnr)
end

local function on_attach(client, bufnr)
  if client.name == "ts_ls" or client.name == "pyright" or client.name == "ruff" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.name == "biome" or client.name == "ruff" then
    for _, capability in ipairs({
      "declarationProvider",
      "definitionProvider",
      "implementationProvider",
      "referencesProvider",
      "typeDefinitionProvider",
      "documentSymbolProvider",
      "workspaceSymbolProvider",
    }) do
      client.server_capabilities[capability] = false
    end
  end

  local opts = { buffer = bufnr, silent = true }
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
  end

  map("n", "gd", function()
    show_location_picker(bufnr, "textDocument/definition", "LSP Definitions")
  end, "Go to definition")
  map("n", "gD", function()
    show_location_picker(bufnr, "textDocument/typeDefinition", "LSP Type Definitions")
  end, "Go to type definition")
  map("n", "gi", function()
    show_location_picker(bufnr, "textDocument/implementation", "LSP Implementations")
  end, "Go to implementation")
  map("n", "gr", function()
    show_location_picker(bufnr, "textDocument/references", "LSP References")
  end, "Find references")
  map("n", "K", vim.lsp.buf.hover, "Show documentation")
  map("n", "<leader>k", vim.lsp.buf.signature_help, "Show signature help")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
  map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
  map("n", "<leader>td", function()
    show_location_picker(bufnr, "textDocument/typeDefinition", "LSP Type Definitions")
  end, "Go to type definition")
  map("n", "<leader>gs", function()
    telescope("lsp_document_symbols")
  end, "Document symbols")
  map("n", "<leader>gS", function()
    telescope("lsp_dynamic_workspace_symbols")
  end, "Workspace symbols")
  map("n", "<leader>e", vim.diagnostic.open_float, "Show line diagnostic")
  map("n", "<leader>ed", function()
    telescope("diagnostics")
  end, "Project diagnostics")
end

function M.format(bufnr, async, quiet)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype

  if formatted_filetypes[filetype] then
    require("conform").format({
      bufnr = bufnr,
      async = async,
      lsp_format = "never",
      quiet = quiet,
    })
    return
  end

  vim.lsp.buf.format({
    bufnr = bufnr,
    async = async,
    timeout_ms = 1000,
  })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
if package.loaded["blink.cmp"] then
  capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
end

vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = on_attach,
  root_markers = { ".git" },
})

vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
})

vim.lsp.config("biome", {
  cmd = { "biome", "lsp-proxy" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "jsonc",
  },
  root_markers = { "biome.json", "biome.jsonc", "package.json", ".git" },
})

vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyrightconfig.json", "pyproject.toml", "setup.cfg", ".git" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "strict",
      },
    },
  },
})

vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "ruff.toml", "pyproject.toml", ".git" },
})

vim.lsp.enable({ "ts_ls", "biome", "pyright", "ruff" })

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
})

return M
