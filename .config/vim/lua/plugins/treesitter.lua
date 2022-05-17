return function()
  require('nvim-treesitter.configs').setup {
    highlight = {
      enable = true,
      disable = { "TelescopePrompt" },
    },
    indent = {
      enable = true,
    },
  }
end
