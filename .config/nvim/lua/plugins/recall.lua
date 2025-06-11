return {
  {
    'fnune/recall.nvim',
    config = function()
      local recall = require('recall')
      recall.setup({
        sign = '',
      })
      vim.keymap.set('n', '<leader>mm', recall.toggle, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>mn', recall.goto_next, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>mp', recall.goto_prev, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>mc', recall.clear, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>ml', function()
        require('telescope').extensions.recall.recall()
      end, { noremap = true, silent = true })
    end,
  },
}
