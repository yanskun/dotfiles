local lspconfig = require('lspconfig')
local util = require('libraries._set_lsp')

lspconfig.svelte.setup {
  on_attach = util.on_attach,
  capabilities = util.capabilities,
  flags = util.flags,
}
