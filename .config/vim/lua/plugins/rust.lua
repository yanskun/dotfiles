return function()
  vim.cmd([[
    syntax enable
    filetype plugin indent on
  ]])
  vim.g.rustfmt_autosave = 1
end
