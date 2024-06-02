if vim.fn.exepath("gopls") ~= "" and vim.fn.exepath("dlv") and vim.fn.exepath("gotests") then
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
else
  vim.notify(
    [[go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/cweill/gotests/...@latest
go install golang.org/x/tools/cmd/goimports@latest]],
    vim.log.levels.WARN,
    { title = "gopls" }
  )
end
