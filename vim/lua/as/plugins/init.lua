local utils = require('as.utils.plugins')

local conf = utils.conf

vim.cmd [[packadd packer.nvim]]

require'packer'.startup {function(use)
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'

  use 'github/copilot.vim'

  use {
    'olimorris/onedark.nvim',
    config = function()
      require('onedarkpro').load()
    end
  }

  --git
  use {
    'ruifm/gitlinker.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use 'lewis6991/gitsigns.nvim'

  use {
    'sindrets/diffview.nvim',
    requires = { 'plenary.nvim' }
  }

  -- (vim script)
  use 'tpope/vim-fugitive'

  -- key mapping
  use {
    "folke/which-key.nvim",
    config = function()
      require('which-key').setup()
    end
  }

  -- explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = conf 'nvim-tree'
  }

  -- tabline
  use {
    'akinsho/bufferline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = conf 'bufferline'
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    config = conf 'treesitter',
    requires = {
      {
        'romgrk/nvim-treesitter-context',
        config = conf 'treesitter-context'
      },
    }
  }

  -- snippets
  use {
    'L3MON4D3/LuaSnip',
    requires = { 'rafamadriz/friendly-snippets' },
    config = conf 'luasnip'
  }

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-telescope/telescope-symbols.nvim',
      'hrsh7th/nvim-cmp'
    },
    config = conf 'telescope'
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    config = conf 'lspconfig',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
    }
  }
  use {
    'williamboman/nvim-lsp-installer',
    requires = 'nvim-lspconfig'
  }

  -- auto completion
  use {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    requires = {
      { 'hrsh7th/cmp-nvim-lsp', after = { 'nvim-cmp', 'nvim-lspconfig' } },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'f3fora/cmp-spell', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'petertriho/cmp-git', after = 'nvim-cmp' },
    },
    config = conf 'cmp'
  }

  -- testings
  use {
    'vim-test/vim-test',
    config = conf 'vim-test'
  }

  use 'rcarriga/vim-ultest'

  -- development
  use {
    'McAuleyPenney/tidy.nvim',
    event = 'BufWritePre'
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {
        close_triple_quotes = true,
      }
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      { 'nvim-lualine/lualine.nvim', opt = true },
      { 'nvim-lua/lsp-status.nvim' }
    },
    config = conf 'lualine'
  }
  end
}
