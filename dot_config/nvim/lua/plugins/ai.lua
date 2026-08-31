local utils = require('libraries._set_config')

local conf = utils.conf

return {
  -- "github/copilot.vim",
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({})
    end,
  },

}
