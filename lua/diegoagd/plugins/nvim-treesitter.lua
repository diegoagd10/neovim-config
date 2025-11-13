return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    -- Prefer pre-compiled binaries if no C compiler is available
    require("nvim-treesitter.install").prefer_git = false
    require("nvim-treesitter.install").compilers = { "gcc", "clang", "cc" }

    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      -- Enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- Enable indentation
      indent = { enable = true },
      -- Ensure these language parsers are installed
      ensure_installed = {
        "python",
        "lua",
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "java",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "bash",
        "gitignore",
      },
      -- Auto install parsers when entering buffer
      auto_install = true,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
