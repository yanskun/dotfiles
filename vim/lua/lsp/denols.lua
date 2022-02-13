if vim.fn.exepath('deno') ~= '' then
  vim.g.markdown_fenced_languages = {
    'ts=typescript'
  }

  local lspconfig = require('lspconfig')

  local util = require('libraries._set_lsp')

  lspconfig.denols.setup{
    root_dir = lspconfig.util.root_pattern("deno.json"),
    init_optons = {
      enable = true,
      lint = true,
      unstable = true,
      importMap = "./import_map.json",
      config = "./deno.json",
    },
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  print('asdf install deno latest')
end
