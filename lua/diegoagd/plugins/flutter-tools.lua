return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = function()
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
        open_cmd = "15split",
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
        -- Note: on_attach and capabilities will be handled automatically
        -- by the plugin, integrating with your existing LSP setup
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
        },
      },
    })
  end,
}
