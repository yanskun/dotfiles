return function()
  local utils = require('libraries._set_config')
  local conf_lsp = utils.conf_lsp

  vim.diagnostic.config({
    virtual_text = false
  })
  vim.o.updatetime = 250
  vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

  -- Launguage Configs
  -- install command
  -- go install golang.org/x/tools/gopls@latest
  -- brew install lua-language-server
  -- npm i -g typescript-language-server
  -- npm i -g yaml-language-server
  -- brew install tflint

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
