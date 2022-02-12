return function()
  local lspconfig = require('lspconfig')
  local utils = require('libraries._sett_lsp')

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
    'sumneko_lua',
    'tflint',
    'tsserver',
    'yamlls',
  }

  local conf_lsp = require('libraries._set_config.conf_lsp')

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = utils.on_attach,
      capabilities = utils.capabilities,
      flags = utils.flags,
    }

    conf_lsp(lsp)
  end
end
