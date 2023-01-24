if vim.fn.exepath('cssmodules-language-server') ~= '' then
  local lspconfig = require('lspconfig')
  local util = require('libraries._set_lsp')

  lspconfig.cssls.setup {
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  vim.notify(
    'npm i -g vscode-langservers-extracted',
    vim.log.levels.WARN,
    { title = 'cssls' }
  )
  vim.notify(
    'npm i -g cssmodules-language-server',
    vim.log.levels.WARN,
    { title = 'cssls' }
  )
end
