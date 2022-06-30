return function()
  local null_ls = require('null-ls')
  local util = require('libraries._set_lsp')

  null_ls.setup {
    sources = {
      null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.code_actions.eslint,
      null_ls.builtins.formatting.prettier,
    },
    on_attach = util.on_attach,
  }
end
