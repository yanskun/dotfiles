-- npm i -g yaml-language-server

local util = require('libraries._sett_lsp')

require'lspconfig'.yamlls.setup{
  on_attach = util.on_attach,
  capabilities = util.capabilities,
  flags = util.flags,
}
