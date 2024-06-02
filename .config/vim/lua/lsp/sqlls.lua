if vim.fn.exepath('sql-language-server') ~= '' then
  local lspconfig = require('lspconfig')
  local util = require('libraries._set_lsp')

  lspconfig.sqlls.setup {
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  vim.notify(
    'npm install -g sql-language-server',
    vim.log.levels.WARN,
    { title = 'sqlls' }
  )
end
