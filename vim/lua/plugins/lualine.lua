return function()
  local function filepath()
    local path = vim.fn.expand('%')
    if vim.fn.winwidth(0) < 84 then
      path = vim.fn.pathshorten(path)
    end
    return path
  end

  local gps = require("nvim-gps")

  local custom_theme = require('lualine.themes.onedark')

  custom_theme.command = {
    a = {
      fg = '#282C34',
      bg = '#E5C07B',
      gui = 'bold',
    }
  }

  require('lualine').setup({
    sections = {
      lualine_b = {
        'branch', 'diagnostics',
      },
      lualine_c = {
        filepath,
        { gps.get_location, cond = gps.is_available },
        'diff'
      },
    },
    options = {
      theme = custom_theme,
      disabled_filetypes = {'NvimTree'}
    }
  })
end
