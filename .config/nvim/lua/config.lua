vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.autoindent = true
vim.opt.colorcolumn = { 100 }
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = ''
vim.opt.nrformats = ''
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.syntax = 'on'
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 500
vim.opt.undofile = true
vim.opt.updatetime = 2000
vim.wo.relativenumber = true

vim.keymap.set('n', '<C-n>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', ':bprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<CR>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics quickfix list' })
vim.keymap.set('n', '<leader>td', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true })
