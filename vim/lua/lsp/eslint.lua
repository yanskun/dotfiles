require'lspconfig'.eslint.setup{
  on_attach = function()
    vim.cmd([[
      au BufWritePre <buffer> silent! EslintFixAll
    ]])
  end
}
