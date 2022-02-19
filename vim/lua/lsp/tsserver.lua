if vim.fn.exepath('typescript-language-server') ~= '' then
  local util = require('libraries._set_lsp')
  local lspconfig = require('lspconfig')

  lspconfig.tsserver.setup {
    root_dir = lspconfig.util.root_pattern('package.json'),
    init_options = {
      lint = true,
      preferences = {
        importModuleSpecifier = 'non-relative',
        importModuleSpecifierPreference = "project-relative",
      }
    },
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      util.on_attach(client, bufnr)

      local ts_utils = require("nvim-lsp-ts-utils")

      ts_utils.setup {}
      ts_utils.setup_client(client)

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
