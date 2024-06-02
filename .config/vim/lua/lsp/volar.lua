if vim.fn.exepath('vue-language-server') ~= '' then
  local lspconfig = require('lspconfig')
  local util = require('libraries._set_lsp')

  lspconfig.volar.setup {
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  vim.notify(
    'npm install -g @volar/vue-language-server',
    vim.log.levels.WARN,
    { title = 'volar' }
  )
end
