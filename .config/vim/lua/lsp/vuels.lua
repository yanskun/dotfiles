if vim.fn.exepath('vls') ~= '' then
  local lspconfig = require('lspconfig')
  local util = require('libraries._set_lsp')

  lspconfig.vuels.setup {
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  print('npm i -g vls')
end
