return function()
  require('which-key').register({
    K = { '<Cmd>Lspsaga hover_doc<CR>', 'lspsaga show hover doc' },
    ['gs'] = {
      name = 'lspsaga',
      r = { '<Cmd>Lspsaga rename<CR>', 'lspsaga rename' },
    }
  }, {
    silent = true,
    }
  )
end
