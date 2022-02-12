-- go install golang.org/x/tools/gopls@latest

local util = require('libraries._sett_lsp')

require'lspconfig'.gopls.setup{
  on_attach = util.on_attach,
  capabilities = util.capabilities,
  flags = util.flags,
}
