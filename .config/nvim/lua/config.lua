-- Set to `false` to disable format on save.
vim.g.autoformat = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.autoindent = true
vim.opt.colorcolumn = { 100 }
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = ''
vim.opt.nrformats = ''
vim.opt.number = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.signcolumn = 'yes:1'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.syntax = 'on'
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 500
vim.opt.undofile = true
vim.opt.updatetime = 2000
vim.wo.relativenumber = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-n>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', ':bprev<CR>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'i', 'x', 's' }, '<C-s>', function()
  vim.api.nvim_command('w')
end, { noremap = true, silent = true })
vim.keymap.set({ 'n', 'i', 'x', 's' }, '<C-S-s>', function()
  vim.api.nvim_command('wa')
end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics quickfix list' })
vim.keymap.set('n', '<leader>z', '<cmd>ZenMode<CR>', { desc = 'Toggle zen mode' })
vim.keymap.set('n', '<leader>td', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P', { desc = 'Paste from clipboard above the line' })
vim.keymap.set('n', '+', '<Cmd>call append(line(".") - 1,     repeat([""], v:count1))<CR>')
vim.keymap.set('n', 'g+', '<Cmd>call append(line("."), repeat([""], v:count1))<CR>')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Switch to insert mode on terminal open',
  pattern = { '*' },
  callback = function()
    if vim.opt.buftype:get() == 'terminal' then
      vim.cmd(':startinsert')
    end
  end,
})
