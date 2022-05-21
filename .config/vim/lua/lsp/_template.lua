if vim.fn.exepath('lsp_name') ~= '' then
  local lspconfig = require('lspconfig')
  local util = require('libraries._set_lsp')

  lspconfig.template.setup {
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  print('lsp install command')
end
