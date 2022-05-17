return function()
  require('which-key').register({
    K = { '<Cmd>Lspsaga hover_doc<CR>', 'lspsaga show hover doc' },
  }, {
    silent = true,
    }
  )
end
