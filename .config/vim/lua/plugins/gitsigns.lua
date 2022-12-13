return function()
  require('gitsigns').setup()

  require('which-key').register({
    g = {
      name = '+git',
      s = { '<cmd>Gitsigns stage_hunk<CR>', 'Stage hunk' },
      r = { '<cmd>Gitsigns reset_hunk<CR>', 'Reset hunk' },
      u = { '<cmd>Gitsigns undo_stage_hunk<CR>', 'Undo stage hunk' },
      p = { '<cmd>Gitsigns preview_hunk<CR>', 'Preview hunk' },
      q = { '<cmd>Gitsigns setqflist<CR>', 'Set quickfix list' },
    }
  }, {
    prefix = '<leader>'
  })
end
