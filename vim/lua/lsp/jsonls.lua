-- npm i -g vscode-json-languageserver

local util = require('libraries._set_lsp')

local lspconfig = require('lspconfig')

lspconfig.jsonls.setup {
  cmd = { 'vscode-json-languageserver', '--stdio' },
  on_attach = util.on_attach,
  capabilities = util.capabilities
}