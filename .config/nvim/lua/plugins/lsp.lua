local utils = require('libraries._set_config')

local conf = utils.conf

return {
  {
    'neovim/nvim-lspconfig',
    config = conf('lspconfig'),
  },
  {
    'williamboman/mason.nvim',
    config = conf('mason'),
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = conf('mason-lspconfig'),
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

  {
    'nvimdev/lspsaga.nvim',
    config = conf('lspsaga'),
  },

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
