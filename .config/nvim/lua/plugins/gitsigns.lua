return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require('gitsigns')
      gitsigns.setup({
        on_attach = function(bufnr)
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end, { desc = 'Next hunk' })

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end, { desc = 'Previous hunk' })

          map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'Hunk inline' })
          map('n', '<leader>gb', gitsigns.blame, { desc = 'Git blame' })
        end,
      })
    end,
  },
}
