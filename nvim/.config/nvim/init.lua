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

-- -- disable diagnostics from LSP
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
vim.lsp.enable(
  'eslint',
  'lua_ls',
  'ruby_lsp',
  'yamlls'
)

local opt = vim.opt

opt.rtp:prepend(lazypath)

opt.expandtab = true
opt.foldexpr = 'nvim_treesitter#foldexpr()'
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
require("mason").setup()
require("mason-lspconfig").setup()
