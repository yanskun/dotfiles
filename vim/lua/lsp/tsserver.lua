-- npm i -g typescript-language-server

local util = require('libraries._set_lsp')

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup {
  root_dir = lspconfig.util.root_pattern('package.json'),
  init_options = {
    lint = true,
  },
  on_attach = function(client, bufnr)
    util.on_attach(client, bufnr)
    util.null_ls_formatting(client)
  end,
  capabilities = util.capabilities,
  flags = util.flags
}
