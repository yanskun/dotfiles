local utils = require('libraries._set_mappings')

vim.g['fern#drawer_keep'] = 1
vim.g['fern#default_hidden'] = 1
local hide_dirs = [[^\%(\.git\|node_modules\)$]]
local hide_files = [[\%(\.byebug\|\.ruby-\|\.DS_Store\)\+]]
vim.g['fern#default_exclude'] = hide_dirs .. [[\|]] .. hide_files
vim.g['fern#renderer'] = 'nerdfont'

vim.cmd([[
  augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
  augroup END
]])

utils.nnoremap('<Leader>f', ':Fern . -reveal=% -drawer -toggle -width=40<CR>')
