if vim.fn.exepath('ruby-lsp') ~= '' then
  local lspconfig = require('lspconfig')
  local util = require('libraries._set_lsp')

  lspconfig.ruby_ls.setup {
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  vim.notify('gem install ruby-lsp', vim.log.levels.WARN, { title = 'LSP not found' })
end
