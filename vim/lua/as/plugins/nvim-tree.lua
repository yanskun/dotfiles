return function()
  require('nvim-tree').setup {
    auto_close = false,

    require('which-key').register {
      ['<leader>t'] = { '<Cmd>NvimTreeToggle<CR>', 'nvim tree open / close toggle' }
    }
  }
end
