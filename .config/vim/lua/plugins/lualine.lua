return function()
  local function filepath()
    local fullpath = vim.fn.expand("%")
    local path = vim.fn.fnamemodify(fullpath, ":~:.")
    if vim.fn.winwidth(0) < 84 then
      path = vim.fn.pathshorten(path)
    end
    return path
  end

  require('lualine').setup({
    sections = {
      lualine_b = {
        'branch', 'diagnostics',
      },
      lualine_c = {
        filepath,
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
