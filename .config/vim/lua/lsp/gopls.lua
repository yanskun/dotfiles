local util = require("libraries._set_lsp")

require("lspconfig").gopls.setup({
  cmd = { "gopls" },
  filetypes = { "go", "gomod" },
  on_attach = function(client, bufnr)
    util.on_attach(client, bufnr, { no_format = true })
  end,
  capabilities = util.capabilities,
  flags = util.flags,
  gopls = {
    experimentalPostfixCompletions = true,
    analyses = {
      unusedparams = true,
      shadow = true,
    },
  },
})
