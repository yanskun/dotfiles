return function()
  local ok, nvimtree = pcall(require, 'nvim-tree')

  if not ok then
    return
  end

  nvimtree.setup {
    disable_netrw = false,
    hijack_netrw = true,
    hijack_cursor = true,
    update_to_buf_dir = {
      enable = true,
      auto_open = true
    },
    update_focused_file = {
      enable = true,
      update_cwd = false,
      auto_open = true,
    },
    actions = {
      open_file = {
        resize_window = true,
      }
    },
    git = {
      enable = true,
      ignore = false,
    }
  }

  require('which-key').register {
    ['<leader>t'] = { '<Cmd>NvimTreeToggle<CR>', 'nvim tree open / close toggle' }
  }
end
