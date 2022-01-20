local utils = require('as.utils.plugins')

local conf = utils.conf

vim.cmd [[packadd packer.nvim]]

require'packer'.startup {function(use)
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'

  use 'github/copilot.vim'

  use {
    'olimorris/onedarkpro.nvim',
    config = function()
      require('onedarkpro').load()
      require('onedarkpro').setup {
        theme = 'onedark',
      }
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
  --use 'tpope/vim-fugitive'

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
    commit = '668de0951a36ef17016074f1120b6aacbe6c4515',
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

  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = 'nvim-lspconfig'
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup {
        sources = {
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.completion.spell,
        }
      }
    end
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
    requires = {
      'akinsho/toggleterm.nvim',
    },
    config = conf 'vim-test'
  }

  use {
    'rcarriga/vim-ultest',
    requires = { 'vim-test/vim-test' },
    run = ':UpdateRemotePlugins',
  }

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
    'kassio/neoterm',
  }

  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        direction = 'horizontal',
        start_in_insert = false,
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return math.floor(vim.o.columns * 0.4)
          end
        end
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

  use {
    'folke/todo-comments.nvim',
    requires = "nvim-lua/plenary.nvim",
    config = conf 'todocomments'
  }

  -- launguages support
  use {
    'ray-x/go.nvim',
    ft = 'go',
    config = function()
      require('go').setup()
    end,
  }

  end
}
