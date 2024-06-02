if vim.fn.exepath('tflint') ~= '' then
  local util = require('libraries._set_lsp')

  require 'lspconfig'.tflint.setup {
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  vim.notify(
    'brew install tflint',
    vim.log.levels.WARN,
    { title = 'tflint' }
  )
end
