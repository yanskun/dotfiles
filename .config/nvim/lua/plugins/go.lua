local utils = require('libraries._set_config')

local conf = utils.conf

return {
  {
    'ray-x/go.nvim',
    ft = 'go',
    config = function()
      require('go').setup()
      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function()
          require('go.format').goimport()
        end,
      })
    end,
  },
  {
    'yanskun/gotests.nvim',
    ft = 'go',
    config = function()
      require('gotests').setup()
    end,
  },
  { 'ray-x/guihua.lua' },
}
