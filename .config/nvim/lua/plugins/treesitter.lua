local utils = require('libraries._set_config')

local conf = utils.conf

return {
  {
    'nvim-treesitter/nvim-treesitter',
    config = conf('treesitter'),
    build = ':TSUpdate',
  },
  {
    dir = '~/Projects/github.com/yanskun/nvim-treesitter-context',
    -- "yanskun/nvim-treesitter-context",
    config = conf('treesitter-context'),
  },
}
