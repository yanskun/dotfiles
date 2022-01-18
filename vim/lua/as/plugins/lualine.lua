return function()
  local function filepath()
    local path = vim.fn.expand('%')
    if vim.fn.winwidth(0) < 84 then
      path = vim.fn.pathshorten(path)
    end
    return path
  end

  require('lualine').setup({
    sections = {
      lualine_c = { filepath, "require'lsp-status'.status()" },
    }
  })
end
