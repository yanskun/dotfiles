local lspconfig = require('lspconfig')

require'lspconfig'.tsserver.setup {
  root_dir = lspconfig.util.root_pattern('package.json'),
  init_options = {
    lint = true,
  },
}
