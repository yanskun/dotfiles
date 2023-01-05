vim.api.nvim_create_autocmd(
  "FileType",
  { pattern = "qf", command = [[ nnoremap <buffer><silent> <CR> <CR>:cclose<CR> ]] }
)
vim.api.nvim_create_autocmd(
  "FileType",
  { pattern = "qf", command = [[ nnoremap <buffer><silent>q <CR>:cclose<CR> ]] }
)

vim.cmd([[
  language en_US.UTF-8
  filetype plugin indent on
]])

vim.cmd([[
  augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab
  augroup END
]])

-- change extension
vim.cmd([[
  autocmd BufNewFile,BufRead *.golden,*textlintrc set filetype=json
]])
