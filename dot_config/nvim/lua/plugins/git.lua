local utils = require('libraries._set_config')

local conf = utils.conf

return {
  {
    'NeogitOrg/neogit',
    config = true,
  },
  {
    'nvim-lua/plenary.nvim', -- required
    lazy = true,
  },
  {
    'sindrets/diffview.nvim', -- optional - Diff integration
    config = conf('diffview'),
  },
  {
    'ibhagwan/fzf-lua', -- optional
    lazy = true,
  },

  {
    'f-person/git-blame.nvim',
    config = function()
      vim.g.gitblame_message_template = '<summary> | <date> | <author>'
      vim.g.gitblame_ignored_filetypes = { 'NvimTree', 'neo-tree' }
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    config = conf('gitsigns'),
  },

  -- {
  --   "sindrets/diffview.nvim",
  --   config = conf("diffview"),
  -- },

  'tpope/vim-fugitive',

  'tpope/vim-rhubarb',
}
