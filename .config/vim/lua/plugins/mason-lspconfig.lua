return function()
  local servers = require("lsp.servers")

  require("mason-lspconfig").setup {
    ensure_installed = servers,
    automatic_installation = true,
  }
end
