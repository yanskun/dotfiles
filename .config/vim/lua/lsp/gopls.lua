if vim.fn.exepath('gopls') ~= '' and vim.fn.exepath('dlv') and
    vim.fn.exepath('gotests') then
  local util = require('libraries._set_lsp')

  require 'lspconfig'.gopls.setup {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod' },
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
    },
  }
else
  vim.notify(
    'go install golang.org/x/tools/gopls@latest',
    vim.log.levels.WARN,
    { title = 'gopls' }
  )
  vim.notify(
    'go install github.com/go-delve/delve/cmd/dlv@latest',
    vim.log.levels.WARN,
    { title = 'gopls' }
  )
  vim.notify(
    'go install github.com/cweill/gotests/...@latest',
    vim.log.levels.WARN,
    { title = 'gopls' }
  )
end
