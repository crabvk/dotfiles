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
        notify_on_error = true,
        formatters_by_ft = {
          css = { 'biome' },
          graphql = { 'prettierd' },
          javascript = { 'biome' },
          json = { 'biome' },
          jsx = { 'prettierd' },
          less = { 'prettierd' },
          lua = { 'stylua' },
          markdown = { 'prettierd' },
          python = { 'ruff_format' },
          scss = { 'prettierd' },
          toml = { 'taplo' },
          typescript = { 'biome' },
          typescriptreact = { 'biome' },
          vue = { 'prettierd' },
          yaml = { 'prettierd' },
          zig = { 'zigfmt' },
          ['*'] = { 'codespell' },
          ['_'] = { 'trim_whitespace' },
        },
        formatters = {
          superhtml = {
            args = { 'fmt', '--stdin', '--syntax-only' },
            stdin = true,
          },
        },
      })
    end,
  },
}
