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

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- configure JSON syntax highlighting for Avro schema files
vim.filetype.add({
  extension = {
    avsc = 'json',
  }
})

local opt = vim.opt

opt.rtp:prepend(lazypath)

opt.expandtab = true
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevelstart = 99
opt.foldmethod = 'expr'
opt.hlsearch = true
opt.ignorecase = true
opt.number = true
opt.shiftwidth = 2
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.tabstop = 2
opt.termguicolors = true

require("lazy").setup("plugins")


