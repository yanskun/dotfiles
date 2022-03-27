return function()
  require('nvim-tree').setup {
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    -- auto_close = true,
    update_to_buf_dir = {
      enable = true,
      auto_open = true
    },
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
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
