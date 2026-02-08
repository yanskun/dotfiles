local utils = require('libraries._set_config')

local conf = utils.conf

return {
  {
    'nvim-treesitter/nvim-treesitter',
    config = conf('treesitter'),
    build = ':TSUpdate',
    dependencies = {
      'OXY2DEV/markview.nvim',
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = conf('treesitter-context'),
  },

  'm-demare/hlargs.nvim',
}
