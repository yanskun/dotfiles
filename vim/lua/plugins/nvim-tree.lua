return function()
  require('nvim-tree').setup {
    auto_close = true,
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    actions = {
      open_file = {
        resize_window = true,
      }
    }
  }

  require('which-key').register {
    ['<leader>t'] = { '<Cmd>NvimTreeToggle<CR>', 'nvim tree open / close toggle' }
  }
end
