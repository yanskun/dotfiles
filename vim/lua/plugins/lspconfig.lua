return function()
  local utils = require('libraries._set_config')
  local conf_lsp = utils.conf_lsp

  vim.diagnostic.config({
    virtual_text = false
  })
  vim.o.updatetime = 250
  vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

  -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  --   vim.lsp.diagnostic.on_publish_diagnostics, {
  --     underline = true,
  --     virtual_text = {
  --       spacing = 4,
  --       prefix = ''
  --     }
  --   }
  -- )

  local servers = {
    'denols',
    'eslint',
    'gopls',
    'jsonls',
    'sumneko_lua',
    'tflint',
    'tsserver',
    'yamlls',
  }

  for _, lsp in ipairs(servers) do
    conf_lsp(lsp)
  end
end
