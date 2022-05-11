if vim.fn.exepath('typescript-language-server') ~= '' then
  local util = require('libraries._set_lsp')
  local lspconfig = require('lspconfig')

  lspconfig.tsserver.setup {
    init_options = {
      lint = true,
      preferences = {
        importModuleSpecifier = 'non-relative',
        importModuleSpecifierPreference = "project-relative",
      }
    },
    on_attach = function(client, bufnr)
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end
      client.server_capabilities.document_formatting = false

      local ts_utils = require("nvim-lsp-ts-utils")
      ts_utils.setup {
        -- import all
        enable_import_on_completion = true,
        -- update imports on file move
        update_imports_on_move = true,
      }
      -- required to fix code action ranges and filter diagnostics
      ts_utils.setup_client(client)

      util.on_attach(client, bufnr)

      require('which-key').register({
        n = {
          name = 'nvim-lsp-ts-utils',
          ['gs'] = { '<Cmd>TSLspOrganize<CR>', 'lsp-ts Organize imports' },
          ['gr'] = { '<Cmd>TSLspRenameFile<CR>', 'lsp-ts Rename file and update imports' },
          ['gi'] = { '<Cmd>TSLspImportAll<CR>', 'lsp-ts Import all missing imports' },
        }
      }, {
          silent = true,
          buffer = bufnr,
        }
      )
    end,
    capabilities = util.capabilities,
    flags = util.flags
  }
else
  print('npm i -g typescript-language-server')
end
