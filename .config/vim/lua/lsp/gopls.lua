if vim.fn.exepath('gopls') ~= '' and vim.fn.exepath('dlv') and
    vim.fn.exepath('gotests') then
  local util = require('libraries._set_lsp')

  require 'lspconfig'.gopls.setup {
    cmd = { 'gopls' },
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  print('go install golang.org/x/tools/gopls@latest')
  print('go install github.com/go-delve/delve/cmd/dlv@latest')
  print('go install github.com/cweill/gotests/...@latest')
end
