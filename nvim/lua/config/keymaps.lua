local map = vim.keymap.set
local pickers = require("config.pickers")
local search = require("config.search")

local silent = { silent = true }

map("n", "<leader>pv", pickers.file_explorer, { desc = "Open file explorer" })
map("n", "<leader>ff", pickers.find_files, { desc = "Find files" })
map("n", "<leader>fs", pickers.live_grep, { desc = "Search text" })
map("n", "<leader>fb", pickers.buffers, { desc = "Find buffers" })
map("n", "<C-p>", pickers.recent_files, { desc = "Recent files" })

map("n", "<Tab>", "<cmd>bnext<cr>", vim.tbl_extend("force", silent, { desc = "Next buffer" }))
map("n", "<S-Tab>", "<cmd>bprevious<cr>", vim.tbl_extend("force", silent, { desc = "Previous buffer" }))
map("n", "<leader>x", "<cmd>bdelete<cr>", vim.tbl_extend("force", silent, { desc = "Close buffer" }))

map("n", "<leader>|", "<cmd>vsplit<cr>", vim.tbl_extend("force", silent, { desc = "Split vertically" }))
map("n", "<leader>\\", "<cmd>vsplit<cr>", vim.tbl_extend("force", silent, { desc = "Split vertically" }))
map("n", "<leader>-", "<cmd>split<cr>", vim.tbl_extend("force", silent, { desc = "Split horizontally" }))
map("n", "<leader>_", "<cmd>split<cr>", vim.tbl_extend("force", silent, { desc = "Split horizontally" }))
map("n", "<leader>us", "<cmd>only<cr>", vim.tbl_extend("force", silent, { desc = "Unsplit all" }))

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })
map("n", "<leader>d", '"_d', { desc = "Delete without yanking" })
map("v", "<leader>d", '"_d', { desc = "Delete without yanking" })
map("n", "<leader>s", search.replace_word, { desc = "Replace current word" })
map("x", "<leader>gr", search.find_visual_in_file, { desc = "Find selection in current file" })
map("x", "<leader>s", search.replace_visual, { desc = "Replace selection in current file" })

map("n", "<leader>f", function()
  require("config.lsp").format(0, true)
end, { desc = "Format document" })
map("n", "<leader>tt", function()
  require("config.terminal").toggle()
end, { desc = "Toggle terminal" })
