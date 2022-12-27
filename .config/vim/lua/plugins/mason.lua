return function()
  local servers = require("lsp.servers")

  require("mason").setup({
    ensure_installed = servers,
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      }
    }
  })
end
