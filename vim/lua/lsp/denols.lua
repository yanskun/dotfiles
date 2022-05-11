if vim.fn.exepath('deno') ~= '' then
  vim.g.markdown_fenced_languages = {
    'ts=typescript'
  }

  local lspconfig = require('lspconfig')

  local util = require('libraries._set_lsp')

  lspconfig.denols.setup{
    cmd = { 'deno', 'lsp' },
    root_dir = lspconfig.util.root_pattern("deno.json", "deps.ts", "deno.jsonc", "tsconfig.json", ".git"),
    on_attach = function(client, bufnr)
      client.server_capabilities.document_formatting = false
      util.on_attach(client, bufnr)
    end,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  print('asdf install deno latest')
end
