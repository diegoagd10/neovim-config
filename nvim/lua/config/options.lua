local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.hlsearch = false
opt.incsearch = true
opt.termguicolors = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.updatetime = 50
opt.colorcolumn = "80"
opt.isfname:append("@-@")
opt.ignorecase = true
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.laststatus = 3
opt.shortmess:append("c")

vim.fn.mkdir(vim.fn.expand("~/.vim/undodir"), "p")
