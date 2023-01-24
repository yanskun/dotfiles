return function()
  local servers = require("lsp.servers")

  require("mason-lspconfig").setup {
    ensure_installed = {
      "cssls",
      "denols",
      "gopls",
      "jsonls",
      "ruby_ls",
      "rust_analyzer",
      "sqlls",
      "sumneko_lua",
      "svelte",
      "tflint",
      "volar",
      "yamlls",
      "zls",
      "tsserver",
    },
    automatic_installation = true,
  }
end
