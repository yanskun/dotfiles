return function()
  local function filepath()
    local path = vim.fn.expand('%')
    if vim.fn.winwidth(0) < 84 then
      path = vim.fn.pathshorten(path)
    end
    return path
  end

  local gps = require("nvim-gps")

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
      theme = 'onedark',
      disabled_filetypes = { 'NvimTree' },
      globalstatus = true,
    }
  })
end
