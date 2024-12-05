local utils = require('libraries._set_config')

local conf = utils.conf

return {
  {
    'neovim/nvim-lspconfig',
    config = conf('lspconfig'),
  },
  { 'hrsh7th/cmp-nvim-lsp' },
  {
    'RRethy/vim-illuminate',
  },

  -- none-ls
  {
    'nvimtools/none-ls.nvim',
    config = conf('null-ls'),
  },
  {
    'nvimtools/none-ls-extras.nvim',
  },
  {
    'gbprod/none-ls-shellcheck.nvim',
  },

  -- {
  --   "kkharji/lspsaga.nvim",
  --   config = conf("lspsaga"),
  -- },

  {
    'akinsho/flutter-tools.nvim',
    config = conf('flutter-tools'),
    ft = 'dart',
  },

  {
    'onsails/diaglist.nvim',
    config = conf('diaglist'),
  },
}
