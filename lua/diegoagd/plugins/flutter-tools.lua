return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = function()
    -- Get LSP config from nvim-lspconfig to ensure consistency
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Define on_attach function with all LSP keybindings
    local on_attach = function(_, bufnr)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
      vim.keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to type definition" })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover text" })
      vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Show signature help" })

      vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = "Add workspace folder" })
      vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = "Remove workspace folder" })
      vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, { buffer = bufnr, desc = "List workspace folders" })

      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Smart rename" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "See available code actions" })

      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format { async = true }
      end, { buffer = bufnr, desc = "Format File" })

      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show diagnostics for line" })

      vim.keymap.set("n", "<leader>lr", function()
        vim.cmd("LspRestart")
        vim.notify("LSP client restarted", vim.log.levels.INFO)
      end, { buffer = bufnr, desc = "Restart LSP client" })
    end

    require("flutter-tools").setup({
      ui = {
        border = "rounded",
        notification_style = "native",
      },
      decorations = {
        statusline = {
          app_version = false,
          device = false,
          project_config = false,
        },
      },
      debugger = {
        enabled = false,
        exception_breakpoints = {},
        evaluate_to_string_in_debug_views = true,
      },
      widget_guides = {
        enabled = false,
      },
      closing_tags = {
        highlight = "ErrorMsg",
        prefix = ">",
        priority = 10,
        enabled = true,
      },
      dev_log = {
        enabled = true,
        notify_errors = false,
        open_cmd = "belowright 15split", -- Open at bottom
        focus_on_open = true,
      },
      dev_tools = {
        autostart = false,
        auto_open_browser = false,
      },
      outline = {
        open_cmd = "30vnew",
        auto_open = false,
      },
      lsp = {
        color = {
          enabled = false,
          background = false,
          foreground = false,
          virtual_text = true,
          virtual_text_str = "■",
        },
        -- Explicitly provide on_attach and capabilities
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
          -- Ensure all diagnostics are shown
          lineLength = 120,
          analysisExcludedFolders = {},
          enableSdkFormatter = true,
        },
      },
    })

    -- Ensure Flutter run buffer opens at the bottom
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "log",
      callback = function()
        -- Check if this is a Flutter buffer
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname:match("Flutter") or bufname:match("flutter") then
          -- Move window to bottom
          vim.cmd("wincmd J")
        end
      end,
      desc = "Move Flutter log buffer to bottom",
    })
  end,
}
