-- https://vim-jp.org/vimdoc-ja/options.html
local o = vim.opt

o.swapfile = false
o.showcmd = true
o.virtualedit = 'onemore'
o.splitright = true
o.mouse = ''

o.number = true
o.cursorline = true
o.cursorcolumn = true
o.termguicolors = true

o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2

o.clipboard = 'unnamed'

o.laststatus = 3

-- vim.diagnostic.config({ virtual_text = true })

vim.cmd([[
  language en_US.UTF-8
  filetype plugin indent on
]])

-- denops
-- set runtimepath-=~/Projects/github.com/yanskun/dps-translate
-- set runtimepath^=~/Projects/github.com/yanskun/dps-change-case.nvim
vim.cmd([[
  set runtimepath-=~/Projects/github.com/yanskun/dps-translate
  set runtimepath-=~/Projects/github.com/yanskun/dps-change-case.nvim
  let g:denops#debug = 0
]])
