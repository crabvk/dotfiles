return {
  {
    'stevearc/conform.nvim',
    config = function()
      vim.keymap.set('n', '<leader>f', function()
        require('conform').format({ async = true, lsp_format = 'fallback' })
      end, { desc = 'Format buffer' })

      local disabled_ft = {
        c = true,
        cpp = true,
      }
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function(args)
          local filetype = vim.bo[args.buf].filetype
          if vim.g.autoformat == false or disabled_ft[filetype] then
            return
          end
          require('conform').format({ bufnr = args.buf })
        end,
      })

      require('conform').setup({
        log_level = vim.log.levels.WARN,
        notify_on_error = false,
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'ruff_format' },
          graphql = { 'prettierd' },
          json = { 'biome' },
          jsx = { 'prettierd' },
          less = { 'prettierd' },
          scss = { 'prettierd' },
          html = { 'prettierd' },
          css = { 'biome' },
          javascript = { 'biome' },
          typescript = { 'biome' },
          typescriptreact = { 'biome' },
          vue = { 'prettierd' },
          yaml = { 'prettierd' },
          ['*'] = { 'codespell' },
          ['_'] = { 'trim_whitespace' },
        },
      })
    end,
  },
}
