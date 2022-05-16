-- https://vim-jp.org/vimdoc-ja/options.html
local o = vim.opt

o.swapfile = false
o.showcmd = true
o.virtualedit = 'onemore'
o.splitright = true

o.number = true
o.cursorline = true
o.cursorcolumn = true

o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2

o.foldmethod = 'indent'
o.foldlevel = 99

o.clipboard = 'unnamedplus'

o.spell = true
local xdg_cfg = os.getenv('XDG_CONFIG_HOME')
if xdg_cfg then
  o.spellfile = xdg_cfg..'/nvim/lua/spell/en.utf-8.add'
end

o.laststatus = 3

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

vim.cmd([[
  autocmd BufNewFile,BufRead *.golden,*textlintrc set filetype=json
]])
