if vim.fn.exepath('typescript-language-server') ~= '' then
  local lspconfig = require('lspconfig')
  local util = require('libraries._set_lsp')

  lspconfig.tsserver.setup {
    root_dir = lspconfig.util.root_pattern("package.json"),
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  print('lsp install command')
end
