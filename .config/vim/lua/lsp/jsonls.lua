if vim.fn.exepath('vscode-json-languageserver') ~= '' then
  local util = require('libraries._set_lsp')

  local lspconfig = require('lspconfig')

  lspconfig.jsonls.setup {
    cmd = { 'vscode-json-languageserver', '--stdio' },
    on_attach = function(client, bufnr)
      client.server_capabilities.document_formatting = false
      util.on_attach(client, bufnr)
    end,
    capabilities = util.capabilities
  }
else
  vim.notify(
    'npm i -g vscode-json-languageserver',
    vim.log.levels.WARN,
    { title = 'jsonls' }
  )
end
