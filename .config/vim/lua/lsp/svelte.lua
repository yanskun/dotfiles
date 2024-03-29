if vim.fn.exepath('svelteserver') ~= '' then
  local lspconfig = require('lspconfig')
  local util = require('libraries._set_lsp')

  lspconfig.svelte.setup {
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  vim.notify(
    'npm install -g svelte-language-server',
    vim.log.levels.WARN,
    { title = 'svelte' }
  )
end
