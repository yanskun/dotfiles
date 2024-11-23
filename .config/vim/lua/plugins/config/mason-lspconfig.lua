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
      "ruby_lsp",
      "rust_analyzer",
      "sqlls",
      "svelte",
      "tailwindcss",
      "tflint",
      "ts_ls",
      "volar",
      "yamlls",
      "zls",
    },
    automatic_installation = true,
  }
end
