local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('config')

if vim.g.vscode then
  return
end

require('lastplace')

local lazy = require('lazy')
lazy.setup({
  spec = {
    { import = 'plugins.autopairs' },
    { import = 'plugins.blink-cmp' },
    { import = 'plugins.colorful-menu' },
    { import = 'plugins.comment' },
    { import = 'plugins.conform' },
    { import = 'plugins.gitsigns' },
    { import = 'plugins.gruvbox' },
    { import = 'plugins.lazydev' },
    { import = 'plugins.lspconfig' },
    { import = 'plugins.lualine' },
    { import = 'plugins.mini' },
    { import = 'plugins.multicursor' },
    { import = 'plugins.neoscroll' },
    { import = 'plugins.recall' },
    { import = 'plugins.sleuth' },
    { import = 'plugins.snacks' },
    { import = 'plugins.surround' },
    { import = 'plugins.telescope' },
    { import = 'plugins.tiny-inline-diagnostic' },
    { import = 'plugins.todo-comments' },
    { import = 'plugins.treesitter' },
    { import = 'plugins.treesitter-context' },
    { import = 'plugins.yazi' },
    { import = 'plugins.zen-mode' },
  },
  install = { colorscheme = { 'gruvbox' } },
  checker = { enabled = false },
})
