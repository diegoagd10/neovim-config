return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate to left window/pane" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate to window/pane below" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate to window/pane above" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate to right window/pane" },
    { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Navigate to previous window/pane" },
  },
}
