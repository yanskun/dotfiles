return function()
  require("mason-lspconfig").setup {
    ensure_installed = {
      "biome",
      "cssls",
      "denols",
      "gopls",
      "jsonls",
      "lua_ls",
      "pylsp",
      "ruby-lsp",
      "rust_analyzer",
      "sqlls",
      "svelte",
      "tailwindcss",
      "tflint",
      "tsserver",
      "volar",
      "yamlls",
      "zls",
    },
    automatic_installation = true,
  }
end
