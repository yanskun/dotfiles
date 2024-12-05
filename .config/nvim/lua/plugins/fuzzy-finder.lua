local utils = require('libraries._set_config')

local conf = utils.conf

return {
  {
    'nvim-telescope/telescope.nvim',
    config = conf('telescope'),
  },
  {
    'nvim-telescope/telescope-symbols.nvim',
  },
  {
    'hrsh7th/nvim-cmp',
  },
  {
    'jonarrien/telescope-cmdline.nvim',
  },

  {
    'fdschmidt93/telescope-egrepify.nvim',
  },
  {
    'nvim-telescope/telescope-frecency.nvim',
  },

  {
    'simonmclean/triptych.nvim',
    event = 'VeryLazy',
    config = conf('triptych'),
  },

  {
    'folke/todo-comments.nvim',
    config = conf('todo-comments'),
  },
}
