local o = vim.o
local wo = vim.wo
local bo = vim.bo

o.swapfile = true
o.showcmd = true
o.virtualedit = 'onemore'

wo.number = true
wo.cursorline = true
wo.cursorcolumn = true

bo.expandtab = true
bo.tabstop = 2

vim.cmd([[
  language en_US
  filetype plugin indent on
  syntax on
  hi Normal ctermbg=NONE guibg=NONE
]])
