return function()
  local utils = require('libraries._set_config')
  local conf_lsp = utils.conf_lsp

  vim.diagnostic.config({
    virtual_text = false
  })
  vim.o.updatetime = 250
  vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

  -- mapping
  require('which-key').register {
    name = 'lsp',
    ['<space>e'] = { '<cmd>lua vim.diagnostic.open_float()<CR>' },
    ['[d'] = { '<cmd>lua vim.diagnostic.goto_prev()<CR>' },
    [']d'] = { '<cmd>lua vim.diagnostic.goto_next()<CR>' },
    ['<space>q'] = { '<cmd>lua vim.diagnostic.setloclist()<CR>' },
  }

  local servers = {
    'denols',
    'gopls',
    'jsonls',
    'sumneko_lua',
    'tflint',
    'yamlls',
  }

  for _, lsp in ipairs(servers) do
    conf_lsp(lsp)
  end
end
