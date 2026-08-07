vim.g.mapleader = " "
vim.g.maplocalleader = " "

local config_dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")
vim.opt.rtp:prepend(config_dir)
package.path = table.concat({
  config_dir .. "/lua/?.lua",
  config_dir .. "/lua/?/init.lua",
  package.path,
}, ";")

require("config.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local output = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to install lazy.nvim:\n", "ErrorMsg" },
      { output, "WarningMsg" },
    }, true, {})
    return
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(require("plugins"), {
  change_detection = { notify = false },
  checker = { enabled = false },
  install = { colorscheme = { "tokyonight" } },
})

require("config.keymaps")
require("config.terminal")
require("config.lsp")
