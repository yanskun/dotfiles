vim.g.markdown_fenced_languages = {
  'ts=typescript'
}


local lspconfig = require('lspconfig')

lspconfig.denols.setup{
  root_dir = lspconfig.util.root_pattern("deno.json"),
  init_optons = {
    enable = true,
    lint = true,
    unstable = true,
    importMap = "./import_map.json",
    config = "./deno.json",
  }
}
