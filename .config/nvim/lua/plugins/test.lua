local utils = require('libraries._set_config')

local conf = utils.conf

return {
  {
    'vim-test/vim-test',
    config = conf('vim-test'),
  },
  {
    'akinsho/toggleterm.nvim',
  },

  {
    'nvim-neotest/neotest',
    config = conf('neotest'),
  },
  {
    'antoinemadec/FixCursorHold.nvim',
  },
  -- Neotest Adapters
  'marilari88/neotest-vitest',

  {
    'mfussenegger/nvim-dap',
    config = conf('dap'),
  },
  {
    'rcarriga/nvim-dap-ui',
    config = conf('dapui'),
  },
  'nvim-neotest/nvim-nio',
  -- dap Adaptars
  'mxsdev/nvim-dap-vscode-js',
  'leoluz/nvim-dap-go',
}
