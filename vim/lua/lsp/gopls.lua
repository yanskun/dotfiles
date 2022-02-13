if vim.fn.exepath('gopls') ~= '' then
  local util = require('libraries._set_lsp')

  require'lspconfig'.gopls.setup{
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  print('go install golang.org/x/tools/gopls@latest')
end
