local utils = require('libraries._set_mappings')

vim.cmd([[
  let test#strategy = "dispatch"
  let test#go#runner = 'gotest'
]])

utils.nnoremap('t<C-n>', ':TestNearest<CR>')
utils.nnoremap('t<C-f>', ':TestFile<CR>')
utils.nnoremap('t<C-s>', ':TestSuite<CR>')
utils.nnoremap('t<C-l>', ':TestLast<CR>')
utils.nnoremap('t<C-g>', ':TestVisit<CR>')
