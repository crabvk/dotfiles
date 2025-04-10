return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format({ async = true, lsp_format = 'fallback' })
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    config = function()
      local conform = require('conform')
      local disable_filetypes = {
        c = true,
        cpp = true,
      }
      local formatters = {
        lua = { 'stylua' },
        python = { 'ruff_format' },
        graphql = { 'prettierd' },
        json = { 'biome' },
        jsx = { 'prettierd' },
        less = { 'prettierd' },
        scss = { 'prettierd' },
        typescript = { 'biome' },
        typescriptreact = { 'biome' },
        vue = { 'prettierd' },
        yaml = { 'prettierd' },
        ['*'] = { 'codespell' },
        ['_'] = { 'trim_whitespace' },
      }
      local web_formatters = {
        html = { 'prettierd' },
        css = { 'biome' },
        javascript = { 'biome' },
      }
      if not vim.g.format_web == false then
        formatters = vim.tbl_deep_extend('force', formatters, web_formatters)
      end
      conform.setup({
        log_level = vim.log.levels.WARN,
        notify_on_error = false,
        format_on_save = function(bufnr)
          local lsp_format_opt
          if disable_filetypes[vim.bo[bufnr].filetype] then
            lsp_format_opt = 'never'
          else
            lsp_format_opt = 'fallback'
          end
          return {
            timeout_ms = 500,
            lsp_format = lsp_format_opt,
          }
        end,
        formatters_by_ft = formatters,
      })
    end,
  },
}
