return function()
  require('lspsaga').setup({
    rename = {
      keys = {
        quit = '<ESC>',
      },
    },
  })

  require('which-key').add({
    { 'K', '<Cmd>Lspsaga hover_doc<CR>', desc = 'lspsaga show hover doc' },
    { 'gs', group = 'lspsaga' },
    { 'gsa', '<Cmd>Lspsaga code_action<CR>', desc = 'lspsaga codeaction' },
    { 'gsr', '<Cmd>Lspsaga rename<CR>', desc = 'lspsaga rename' },
  })

  require('which-key').add({
    { 'gs', group = 'lspsaga', mode = 'v' },
    { 'gsa', '<Cmd><C-U>Lspsaga range_code_action<CR>', desc = 'lspsaga range codeaction', mode = 'v' },
  })
end
