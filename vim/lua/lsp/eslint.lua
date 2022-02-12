require'lspconfig'.eslint.setup{
  on_attach = function(_client, buffer)
    vim.cmd([[
      au BufWritePre <buffer> silent! EslintFixAll
    ]])

    require('which-key').register({
      qe = { '<cmd>EslintFixAll<cr>', 'ESLint Fix All' },
    }, { buffer = buffer })
  end
}
