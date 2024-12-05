local utils = require('libraries._set_config')

local conf = utils.conf

return {
  {
    'nvim-lualine/lualine.nvim',
    config = conf('lualine'),
  },
  {
    'nvim-lua/lsp-status.nvim',
  },

  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
  },
}
