local utils = require('libraries._set_config')

local conf = utils.conf

return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = conf('cmp'),
  },
  { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-lspconfig' },
  { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
  { 'f3fora/cmp-spell', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' },
  { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
  { 'petertriho/cmp-git', after = 'nvim-cmp' },
  {
    'zbirenbaum/copilot-cmp',
    after = { 'nvim-cmp', 'copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'onsails/lspkind.nvim' },
}
