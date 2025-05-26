return function()
  require('mason-lspconfig').setup {
    ensure_installed = {
      'buf_ls',
      'biome',
      'cssls',
      'denols',
      'gopls',
      'jsonls',
      'lua_ls',
      'prismals',
      'pylsp',
      'ruby_lsp',
      'rust_analyzer',
      'sqlls',
      'svelte',
      'tailwindcss',
      'tflint',
      'ts_ls',
      'volar',
      'yamlls',
      'zls',
    },
    automatic_installation = true,
  }
end
