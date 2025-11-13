return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  enabled = true,
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Add border to floating window
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.hover, { border = "single", silent = true })
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single", silend = true })

    -- Make float window transparent start
    local set_hl_for_floating_window = function()
      vim.api.nvim_set_hl(0, "NormalFloat", {
        link = "Normal",
      })
      vim.api.nvim_set_hl(0, "FloatBorder", {
        bg = "none",
      })
    end

    set_hl_for_floating_window()

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      desc = "Avoid overwritten by loading color schemes later",
      callback = set_hl_for_floating_window,
    })

    -- Make float window transparent end
    local on_attach = function(_, bufnr)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
      vim.keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to type definition" })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover text" })
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show signature" })

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

      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show diagnostics for line" })
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()
    local signs = { Error = "✖", Warn = "", Hint = "󰠠", Info = "" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Configure TypeScript server (new API)
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Configure HTML server (new API)
    vim.lsp.config("html", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Configure Angular server with custom root_dir (new API)
    vim.lsp.config("angularls", {
      capabilities = capabilities,
      on_attach = on_attach,
      root_markers = { "angular.json", "project.json", "nx.json" },
    })

    -- Configure Lua server with special settings (new API)
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- Configure CSS server (new API)
    vim.lsp.config("cssls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Configure Python server with settings (new API)
    vim.lsp.config("pyright", {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    })

    -- Enable all configured LSP servers (new API)
    vim.lsp.enable({ "ts_ls", "html", "angularls", "lua_ls", "cssls", "pyright" })

    -- Note: Java (jdtls) is handled by nvim-java plugin
  end,
}
