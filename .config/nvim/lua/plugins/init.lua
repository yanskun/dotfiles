local utils = require('libraries._set_config')

local conf = utils.conf

return {
  'nvim-lua/plenary.nvim',

  {
    'navarasu/onedark.nvim',
    config = conf('onedark'),
    lazy = false,
    priority = 1000,
  },

  {
    dir = '~/Projects/github.com/yanskun/ollama-cmp',
    dev = true,
    config = function()
      require('ollama_cmp').setup()
    end,
  },

  -- TODO: suggest suport
  -- {
  -- 	"folke/noice.nvim",
  -- 	event = "VeryLazy",
  -- 	config = conf("noice"),
  -- },

  {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup({
        plugins = {
          tmux = { enabled = true },
          alacritty = { enabled = true, font = 15 },
        },
      })
    end,
  },

  {
    'sphamba/smear-cursor.nvim',
    opts = {},
  },

  {
    'mcauley-penney/visual-whitespace.nvim',
    config = true,
  },

  {
    'petertriho/nvim-scrollbar',
    config = conf('nvim-scrollbar'),
  },

  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({
        background_colour = '#000000',
      })
      vim.notify = require('notify')
    end,
  },

  -- key mapping
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup()
    end,
  },
  {
    'echasnovski/mini.icons',
  },
  {
    'nvim-tree/nvim-web-devicons',
  },

  -- explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false,
    priority = 100,
    config = conf('neo-tree'),
  },
  {
    'MunifTanjim/nui.nvim',
  },
  {
    'kyazdani42/nvim-web-devicons',
  },
  {
    's1n7ax/nvim-window-picker',
    -- "yanskun/nvim-window-picker",
    commit = '6e9875711b9d5cefcf77cc6e30dcce53135b9cc5',
    config = conf('nvim-window-picker'),
  },

  -- wildmenu
  {
    'gelguy/wilder.nvim',
    config = conf('wilder'),
  },

  -- buffer
  {
    'akinsho/bufferline.nvim',
    config = conf('bufferline'),
  },

  -- snippets
  {
    'L3MON4D3/LuaSnip',
    config = conf('luasnip'),
  },
  { 'rafamadriz/friendly-snippets' },

  -- development
  -- brackets
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        close_triple_quotes = true,
      })
    end,
  },
  {
    'kylechui/nvim-surround',
    -- :h nvim-surround.usage
  },

  -- code snapshot
  {
    'ellisonleao/carbon-now.nvim',
    lazy = true,
    cmd = { 'CarbonNow' },
    config = function()
      require('carbon-now').setup({
        open_cmd = 'open',
      })
    end,
  },

  -- tag
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },

  -- comment
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },

  -- indent
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup({
        scope = {
          show_start = false,
        },
      })
    end,
  },

  -- terminal
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup({
        direction = 'horizontal',
        start_in_insert = false,
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return math.floor(vim.o.columns * 0.4)
          end
        end,
      })
    end,
  },

  -- color
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

  -- match info
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup()
    end,
  },

  -- deno
  -- "vim-denops/denops.vim",
  -- "yanskun/dps-translate.nvim",

  'yanskun/change-case.nvim',

  -- WakaTime
  'wakatime/vim-wakatime',

  -- props
  'dstein64/vim-startuptime',
}
