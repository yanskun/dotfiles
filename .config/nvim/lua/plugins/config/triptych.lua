return function()
  require('triptych').setup()

  require('which-key').add({
    { '<leader>-', '<Cmd>Triptych<CR>', desc = 'Open Triptych, Directory browser' },
  })
end
