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
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        filepath,
      },
      lualine_c = {
        "require'lsp-status'.status()",
        'diagnostics',
        'diff',
      },
    },
    options = {
      theme = 'onedark',
      disabled_filetypes = { 'NvimTree', 'neo-tree' },
      globalstatus = true,
    }
  })
end
