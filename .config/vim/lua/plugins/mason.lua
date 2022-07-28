return function()
  require("mason").setup({
    ensure_installed = {
      "delve",
      "deno",
      "eslint-lsp",
      "go-debug-adapter",
      "golangci-lint",
      "gopls",
      "json-lsp",
      "lua-language-server",
      "rust-analyzer",
      "tflint",
      "yaml-language-server",
      "zls"
    },
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      }
    }
  })
end
