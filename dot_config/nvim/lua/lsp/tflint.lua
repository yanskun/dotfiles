local util = require('libraries._set_lsp')

require 'lspconfig'.tflint.setup {
  on_attach = util.on_attach,
  capabilities = util.capabilities,
  flags = util.flags,
}
