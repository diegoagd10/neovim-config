return {
  "nvim-telescope/telescope.nvim",
  config = function()
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git Files" })
    vim.keymap.set("n", "<leader>fs", function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = "Search with Grep" })
    vim.keymap.set("v", "<leader>fs", function()
      -- Yank the selected text to the unnamed register
      vim.cmd('noau normal! "vy"')
      local text = vim.fn.getreg("v")
      -- Escape special characters for grep
      text = vim.fn.escape(text, "\\/.*$^~[]")
      builtin.grep_string({ search = text })
    end, { desc = "Search selected text with Grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
  end,
}
