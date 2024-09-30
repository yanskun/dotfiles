if vim.fn.exepath('typescript-language-server') ~= '' then
  local lspconfig = require('lspconfig')
  local util = require('libraries._set_lsp')

  lspconfig.ts_ls.setup {
    root_dir = lspconfig.util.root_pattern("package.json"),
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
    cmd = { "typescript-language-server", "--stdio" }
  }
else
  vim.notify(
    'npm install -g typescript-language-server',
    vim.log.levels.WARN,
    { title = 'ts_ls' }
  )
end
