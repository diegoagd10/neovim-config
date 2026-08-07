return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      terminal_colors = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local telescope_config = require("telescope.config")
      local vimgrep_arguments = vim.list_extend({}, telescope_config.values.vimgrep_arguments)

      vim.list_extend(vimgrep_arguments, {
        "--hidden",
        "--glob",
        "!**/.git/*",
        "--glob",
        "!**/node_modules/*",
        "--glob",
        "!**/dist/*",
        "--glob",
        "!**/build/*",
        "--glob",
        "!**/.cache/*",
      })

      telescope.setup({
        defaults = {
          vimgrep_arguments = vimgrep_arguments,
          file_ignore_patterns = {
            "/%.git/",
            "/node_modules/",
            "/dist/",
            "/build/",
            "/%.cache/",
          },
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
            preview_width = 0.55,
          },
        },
        pickers = {
          find_files = {
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--glob",
              "!**/.git/*",
              "--glob",
              "!**/node_modules/*",
              "--glob",
              "!**/dist/*",
              "--glob",
              "!**/build/*",
              "--glob",
              "!**/.cache/*",
            },
          },
        },
      })
    end,
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      require("config.multicursor").setup()
    end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    lazy = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = { preset = "super-tab" },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        javascript = { "biome" },
        javascriptreact = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        python = { "ruff_format" },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "never",
      },
      notify_on_error = true,
      notify_no_formatters = false,
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        { "<leader>b", group = "buffers" },
        { "<leader>e", group = "diagnostics" },
        { "<leader>f", group = "find / format" },
        { "<leader>g", group = "symbols" },
        { "<leader>m", group = "multicursor" },
        { "<leader>t", group = "terminal" },
        { "<leader>w", group = "windows" },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "tokyonight",
        globalstatus = true,
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
}
