function default_config(server)
  local lspconfig = require('lspconfig')
  local util = require('libraries._set_lsp')

  lspconfig[server].setup {
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
end

return default_config
