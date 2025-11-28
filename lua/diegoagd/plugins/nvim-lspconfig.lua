return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  enabled = true,
  config = function()
    -- Auto-install pylsp-rope if pylsp is installed but rope plugin is missing
    local function ensure_pylsp_rope()
      local pylsp_path = vim.fn.stdpath("data") .. "/mason/packages/python-lsp-server"
      local venv_pip = pylsp_path .. "/venv/bin/pip"

      -- Check if pylsp is installed
      if vim.fn.isdirectory(pylsp_path) == 1 and vim.fn.executable(venv_pip) == 1 then
        -- Check if pylsp-rope is already installed
        local check_cmd = string.format("%s list 2>/dev/null | grep -q pylsp-rope", venv_pip)
        local result = vim.fn.system(check_cmd)

        if vim.v.shell_error ~= 0 then
          -- pylsp-rope not found, install it
          vim.notify("Installing pylsp-rope for refactoring support...", vim.log.levels.INFO)
          local install_cmd = string.format("%s install pylsp-rope", venv_pip)
          vim.fn.jobstart(install_cmd, {
            on_exit = function(_, exit_code)
              if exit_code == 0 then
                vim.notify("pylsp-rope installed successfully! Restart Neovim to enable refactoring.", vim.log.levels.INFO)
              else
                vim.notify("Failed to install pylsp-rope", vim.log.levels.ERROR)
              end
            end,
          })
        end
      end
    end

    -- Run check after Mason installs packages
    vim.api.nvim_create_autocmd("User", {
      pattern = "MasonToolsUpdateCompleted",
      callback = ensure_pylsp_rope,
      desc = "Auto-install pylsp-rope after Mason updates",
    })

    -- Also run on VimEnter in case pylsp is already installed
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.defer_fn(ensure_pylsp_rope, 1000)  -- Delay 1 second to let Mason initialize
      end,
      desc = "Ensure pylsp-rope is installed on startup",
    })

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

    -- Configure Ruff LSP for Python linting and formatting (new API)
    vim.lsp.config("ruff", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Configure Python LSP Server with rope for refactoring (new API)
    vim.lsp.config("pylsp", {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        pylsp = {
          plugins = {
            -- Enable rope for refactoring (extract method, etc.)
            rope_autoimport = { enabled = true },
            rope_completion = { enabled = true },
            rope_refactoring = { enabled = true },  -- This enables extract method/variable
            -- Disable conflicting plugins since we use pyright and ruff
            pycodestyle = { enabled = false },
            mccabe = { enabled = false },
            pyflakes = { enabled = false },
            pylint = { enabled = false },
            autopep8 = { enabled = false },
            yapf = { enabled = false },
          },
        },
      },
    })

    -- Enable all configured LSP servers (new API)
    vim.lsp.enable({ "ts_ls", "html", "angularls", "lua_ls", "cssls", "pyright", "ruff", "pylsp" })

    -- Note: Java (jdtls) is handled by nvim-java plugin
  end,
}
