vim.cmd([[
  autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR>
]])
require'lspconfig'.eslint.setup{}
