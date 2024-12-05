local utils = require('libraries._set_config')

local conf = utils.conf

return {
  {
    'rust-lang/rust.vim',
    ft = 'rust',
    config = conf('rust'),
  },
  {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    config = function()
      require('rust-tools').setup({
        hover_with_actions = false,
      })
    end,
  },
}
