return function()
  require('todo-comments').setup()

  require('which-key').register {
    ['<leader>ft'] = { '<Cmd>TodoTelescope<CR>', 'todo comments for telescope' }
  }
end
