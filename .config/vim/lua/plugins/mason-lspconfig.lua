return function()
  require("mason-lspconfig").setup {
    ensure_installed = {
      "biome",
      "cssls",
      "denols",
      "gopls",
      "jsonls",
      "ruby-lsp",
      "rust_analyzer",
      "sqlls",
      "lua_ls",
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
