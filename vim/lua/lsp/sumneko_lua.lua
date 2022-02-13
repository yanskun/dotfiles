-- brew install lua-language-server

local util = require('libraries._set_lsp')
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'},
      },
    },
  },
  on_attach = util.on_attach,
  capabilities = util.capabilities,
  flags = util.flags,
}
