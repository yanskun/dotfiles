if vim.fn.exepath('tflint') ~= '' then
  local util = require('libraries._set_lsp')

  require 'lspconfig'.tflint.setup {
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  print('brew install tflint')
end
