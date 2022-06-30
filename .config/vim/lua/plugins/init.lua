local utils = require('libraries._set_config')

local conf = utils.conf
local conf_lsp = utils.conf_lsp

vim.cmd [[packadd packer.nvim]]

require 'packer'.startup { function(use)
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

  -- git
  use {
    'f-person/git-blame.nvim',
    config = function()
      vim.g.gitblame_message_template = '<summary> | <date> | <author>'
      vim.g.gitblame_ignored_filetypes = { 'NvimTree', 'neo-tree' }
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    'sindrets/diffview.nvim',
    requires = { 'plenary.nvim' },
    config = conf 'diffview'
  }

  -- NOTE: vim script, switch when lua script comes out
  use 'tpope/vim-fugitive'

  use 'tpope/vim-rhubarb'

  -- key mapping
  use {
    "folke/which-key.nvim",
    config = function()
      require('which-key').setup()
    end
  }

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-telescope/telescope-symbols.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = conf 'telescope'
  }

  use {
    'folke/todo-comments.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = conf 'todo-comments',
  }

  -- explorer
  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   requires = { 'kyazdani42/nvim-web-devicons' },
  --   config = conf 'nvim-tree'
  -- }
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      {
        's1n7ax/nvim-window-picker',
        tag = "1.*",
        config = conf 'nvim-window-picker',
      }
    },
    config = conf 'neo-tree',
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

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    config = conf 'lspconfig',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'RRethy/vim-illuminate',
    }
  }

  use {
    'williamboman/nvim-lsp-installer',
    requires = 'nvim-lspconfig',
    config = function()
      require('nvim-lsp-installer').setup {}
    end
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = conf_lsp 'null-ls',
    after = 'nvim-lspconfig',
  }

  use {
    'glepnir/lspsaga.nvim',
    config = conf 'lspsaga',
  }

  use {
    'akinsho/flutter-tools.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = conf 'flutter-tools',
    ft = 'dart',
    module = 'flutter-tools'
  }

  use 'jose-elias-alvarez/nvim-lsp-ts-utils'

  -- autocompletion
  use {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    requires = {
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-lspconfig' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'f3fora/cmp-spell', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'petertriho/cmp-git', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'onsails/lspkind.nvim' }
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
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim"
    }
  }

  use {
    'mfussenegger/nvim-dap',
    config = conf 'dap',
    requires = {
      {
        'rcarriga/nvim-dap-ui',
        requires = { 'mfussenegger/nvim-dap' },
        config = conf 'dapui'
      },
      {
        'leoluz/nvim-dap-go',
        config = function()
          require('dap-go').setup()
        end
      },
    }
  }

  -- development
  -- trim white space
  use {
    'McAuleyPenney/tidy.nvim',
    event = 'BufWritePre'
  }

  -- brackets
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {
        close_triple_quotes = true,
      }
    end
  }

  -- comment
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- indent
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup()
    end
  }

  -- formatter
  use {
    'mhartington/formatter.nvim',
    config = conf 'formatter'
  }

  -- terminal
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

  -- scrollbar
  use {
    'petertriho/nvim-scrollbar',
    config = function()
      require("scrollbar").setup()
    end
  }

  -- color
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }

  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      { 'lewis6991/spellsitter.nvim',
        config = function()
          require('spellsitter').setup {
            enable = true,
          }
        end
      },
      'nvim-lua/lsp-status.nvim'
    },
    config = conf 'lualine'
  }

  -- quickfix
  use {
    'https://gitlab.com/yorickpeterse/nvim-pqf',
    event = 'BufReadPre',
    config = function()
      require('pqf').setup()
    end
  }

  use {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
  }

  -- launguages support
  -- go
  use {
    'ray-x/go.nvim',
    ft = 'go',
    config = function()
      require('go').setup()
      vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
    end,
  }
  use {
    'yasudanaoya/gotests.nvim',
    ft = 'go',
    config = function()
      require('gotests').setup()
    end
  }

  -- deno
  use 'vim-denops/denops.vim'
  use 'yasudanaoya/dps-translate.nvim'

  -- markdown
  use 'ellisonleao/glow.nvim'

end
}
