-- https://vim-jp.org/vimdoc-ja/options.html
local o = vim.o

o.swapfile = true
o.showcmd = true
o.virtualedit = 'onemore'

o.number = true
o.cursorline = true
o.cursorcolumn = true

o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2

vim.cmd([[
  language en_US
  filetype plugin indent on
]])

vim.cmd([[
  augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab
  augroup END
]])
