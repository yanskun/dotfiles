local utils = require("libraries._set_config")

local conf = utils.conf

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- vim.cmd([[packadd packer.nvim]])

require("lazy").setup({
  "nvim-lua/plenary.nvim",

  "github/copilot.vim",

  {
    "navarasu/onedark.nvim",
    config = conf("onedark"),
    lazy = false,
    priority = 999,
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },

  -- git
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_message_template = "<summary> | <date> | <author>"
      vim.g.gitblame_ignored_filetypes = { "NvimTree", "neo-tree" }
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = conf("gitsigns"),
  },

  {
    "sindrets/diffview.nvim",
    dependencies = { "plenary.nvim" },
    config = conf("diffview"),
  },

  "tpope/vim-fugitive",

  "tpope/vim-rhubarb",

  -- key mapping
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-symbols.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = conf("telescope"),
  },

  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = conf("todo-comments"),
  },

  -- explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        config = conf("nvim-window-picker"),
      },
    },
    config = conf("neo-tree"),
  },

  -- buffer
  {
    "akinsho/bufferline.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = conf("bufferline"),
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- commit = "668de0951a36ef17016074f1120b6aacbe6c4515",
    config = conf("treesitter"),
    build = ":TSUpdate",
    dependencies = {
      {
        "romgrk/nvim-treesitter-context",
        config = conf("treesitter-context"),
      },
      -- "p00f/nvim-ts-rainbow"
    },
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = conf("luasnip"),
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    config = conf("lspconfig"),
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "RRethy/vim-illuminate",
    },
  },

  {
    "williamboman/mason.nvim",
    config = conf("mason"),
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    }
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = conf("null-ls"),
    -- after = "nvim-lspconfig",
  },

  {
    "kkharji/lspsaga.nvim",
    config = conf("lspsaga"),
  },

  {
    "akinsho/flutter-tools.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = conf("flutter-tools"),
    ft = "dart",
    -- module = "flutter-tools",
  },

  {
    "onsails/diaglist.nvim",
    config = conf("diaglist"),
  },

  -- autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-lspconfig" },
      { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "f3fora/cmp-spell", after = "nvim-cmp" },
      { "hrsh7th/cmp-vsnip", after = "nvim-cmp" },
      { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
      { "petertriho/cmp-git", after = "nvim-cmp" },
      { "saadparwaiz1/cmp_luasnip" },
      { "onsails/lspkind.nvim" },
    },
    config = conf("cmp"),
  },

  -- testings
  {
    "vim-test/vim-test",
    dependencies = {
      "akinsho/toggleterm.nvim",
    },
    config = conf("vim-test"),
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
  },

  {
    "mfussenegger/nvim-dap",
    config = conf("dap"),
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = conf("dapui"),
      },
      {
        "leoluz/nvim-dap-go",
        config = function()
          require("dap-go").setup()
        end,
      },
    },
  },

  -- development
  -- brackets
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        close_triple_quotes = true,
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    -- :h nvim-surround.usage
  },

  -- comment
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- indent
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup()
    end,
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        direction = "horizontal",
        start_in_insert = false,
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return math.floor(vim.o.columns * 0.4)
          end
        end,
      })
    end,
  },

  -- scrollbar
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
  },

  -- color
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- match info
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
    end,
  },

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-lua/lsp-status.nvim",
    },
    config = conf("lualine"),
  },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

  -- launguages support
  -- go
  {
    "ray-x/go.nvim",
    ft = "go",
    config = function()
      require("go").setup()
      -- vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
    end,
  },
  {
    "yanskun/gotests.nvim",
    ft = "go",
    config = function()
      require("gotests").setup()
    end,
  },

  -- Rust
  {
    "rust-lang/rust.vim",
    ft = "rust",
    config = conf('rust'),
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
      require('rust-tools').setup({
        hover_with_actions = false,
      })
    end,
  },

  -- Zig
  {
    "ziglang/zig.vim",
    ft = { "zig", "zir" },
  },

  -- deno
  "vim-denops/denops.vim",
  "yanskun/dps-translate.nvim",
  "skanehira/denops-silicon.vim",

  -- markdown
  "ellisonleao/glow.nvim",

  "yanskun/change-case.nvim",

  -- WakaTime
  'wakatime/vim-wakatime',

  -- props
  'dstein64/vim-startuptime',
})
