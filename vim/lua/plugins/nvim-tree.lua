return function()
  require('nvim-tree').setup {
    auto_close = true,
    disable_netrw = false,
    hijack_netrw = false,
    hijack_cursor = true,
  }

  require('which-key').register {
    ['<leader>t'] = { '<Cmd>NvimTreeToggle<CR>', 'nvim tree open / close toggle' }
  }
end
