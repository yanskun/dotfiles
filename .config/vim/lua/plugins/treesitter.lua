return function()
  if vim.fn.exepath('tree-sitter') ~= '' then
    require('nvim-treesitter.configs').setup {
      highlight = {
        enable = true,
        disable = { "TelescopePrompt" },
      },
      indent = {
        enable = true,
      },
    }
  else
    print('brew install tree-sitter')
  end
end
