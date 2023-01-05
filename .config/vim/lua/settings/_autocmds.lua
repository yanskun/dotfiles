vim.api.nvim_create_autocmd(
  "FileType",
  { pattern = "qf", command = [[ nnoremap <buffer><silent> <CR> <CR>:cclose<CR> ]] }
)
vim.api.nvim_create_autocmd(
  "FileType",
  { pattern = "qf", command = [[ nnoremap <buffer><silent>q <CR>:cclose<CR> ]] }
)

vim.cmd([[
  augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab
  augroup END
]])

-- change filetype
vim.api.nvim_create_autocmd(
  "BufNewFile,BufRead",
  {
    pattern = "*.golden,*textlintrc",
    command = [[ set filetype=json ]],
  }
)
