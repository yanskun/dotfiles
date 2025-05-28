return function()
  require('which-key').add({
    mode = { 'n', 'v' },
    { '<leader>g', group = 'git' },
    { '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>', desc = 'Preview hunk' },
    { '<leader>gq', '<cmd>Gitsigns setqflist<CR>', desc = 'Set quickfix list' },
    { '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', desc = 'Reset hunk' },
    { '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>', desc = 'Stage hunk' },
    { '<leader>gu', '<cmd>Gitsigns undo_stage_hunk<CR>', desc = 'Undo stage hunk' },
  })
end
