local utils = require('libraries._set_mappings')

-- disable cross key
utils.nnoremap('<Up>', '<nop>')
utils.nnoremap('<Down>', '<nop>')
utils.nnoremap('<Left>', '<nop>')
utils.nnoremap('<Right>', '<nop>')
utils.vnoremap('<Up>', '<nop>')
utils.vnoremap('<Down>', '<nop>')
utils.vnoremap('<Left>', '<nop>')
utils.vnoremap('<Right>', '<nop>')

utils.tnoremap('<Esc>', '<C-\\><C-n>')

-- move line up/down
utils.nnoremap('j', 'gj')
utils.nnoremap('k', 'gk')
utils.vnoremap('j', 'gj')
utils.vnoremap('k', 'gk')
