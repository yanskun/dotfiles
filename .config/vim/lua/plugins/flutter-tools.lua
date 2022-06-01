local util = require('libraries._set_lsp')

return function ()
  require("flutter-tools").setup {
    flutter_lookup_cmd = 'asdf where flutter',
    lsp = {
      on_attach = util.on_attach,
      capabilities = util.capabilities
    }
  }
end
