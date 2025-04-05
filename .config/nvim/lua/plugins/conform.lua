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
    opts = {
      --log_level = vim.log.levels.DEBUG,
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = {
          c = true,
          cpp = true,
        }
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
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_format' },
        css = { 'biome' },
        graphql = { 'prettierd' },
        html = { 'prettierd' },
        json = { 'biome' },
        jsx = { 'prettierd' },
        javascript = { 'biome' },
        less = { 'prettierd' },
        scss = { 'prettierd' },
        typescript = { 'biome' },
        typescriptreact = { 'biome' },
        vue = { 'prettierd' },
        yaml = { 'prettierd' },
        ['*'] = { 'codespell' },
        ['_'] = { 'trim_whitespace' },
      },
    },
  },
}
