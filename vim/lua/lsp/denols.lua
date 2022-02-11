vim.g.markdown_fenced_languages = {
  'ts=typescript'
}

require'lspconfig'.denols.setup{
  root_dir = require'lspconfig'.util.root_pattern("deno.json"),
  init_optons = {
    enable = true,
    lint = true,
  }
}
