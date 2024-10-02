local lspconfig = require('lspconfig')
local util = require('libraries._set_lsp')

lspconfig.ts_ls.setup {
  root_dir = lspconfig.util.root_pattern("package.json"),
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "vue" },
  on_attach = util.on_attach,
  capabilities = util.capabilities,
  flags = util.flags,
  cmd = { "typescript-language-server", "--stdio" }
}
