return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local function map(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          local function quickfix()
            vim.lsp.buf.code_action({
              filter = function(action)
                return action.isPreferred
              end,
              apply = true,
            })
          end
          local builtin = require('telescope.builtin')
          map('grr', builtin.lsp_references, 'Go to references')
          map('gri', builtin.lsp_implementations, 'Go to implementation')
          map('gO', builtin.lsp_document_symbols, 'Document symbols')
          map('gd', builtin.lsp_definitions, 'Go to definition')
          map('gD', vim.lsp.buf.declaration, 'Go to declaration')
          map('<leader>D', builtin.lsp_type_definitions, 'Type definition')
          map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, 'Workspace symbols')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code action', { 'n', 'x' })
          map('<leader>qf', quickfix, 'Quick fix')
          map('<leader>dn', function()
            vim.diagnostic.jump({ count = 1 })
          end, 'Go to next diagnostic')
          map('<leader>dp', function()
            vim.diagnostic.jump({ count = -1 })
          end, 'Go to previous diagnostic')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, 'Toggle inlay hints')
          end
        end,
      })

      vim.diagnostic.config({
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = { min = vim.diagnostic.severity.HINT } },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
          },
        },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })

      -- See `:help lspconfig-all` for a list of all the pre-configured LSPs.
      local servers = {
        cspell = {},
        clangd = {},
        html = {},
        emmet_language_server = {},
        vtsls = {},
        biome = {},
        cssls = {},
        css_variables = {},
        pyright = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                globals = { 'vim' },
                disable = { 'missing-fields' },
              },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, {
        'stylua',
        'prettierd',
        'ruff',
        'codespell',
      })
      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local lspconfig = require('lspconfig')
      local blink_cmp = require('blink.cmp')
      require('mason-lspconfig').setup({
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server)
            local config = servers[server] or {}
            config.capabilities = blink_cmp.get_lsp_capabilities(capabilities)
            lspconfig[server].setup(config)
          end,
        },
      })
    end,
  },
}
