local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

local opt = vim.opt

opt.rtp:prepend(lazypath)

opt.expandtab = true
opt.foldmethod = 'syntax'
opt.hlsearch = true
opt.ignorecase = true
opt.number = true
opt.shiftwidth = 2
opt.smartcase = true
opt.tabstop = 2
opt.termguicolors = true

require("lazy").setup("plugins")

