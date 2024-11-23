return function()
  if vim.fn.exepath('tree-sitter') ~= '' then
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        "css",
        "dart",
        "go",
        "html",
        "lua",
        "rust",
        "scss",
        "terraform",
        "tsx",
        "typescript",
        "vue",
        "yaml",
        "zig",
      },
      highlight = {
        enable = true,
        disable = { "TelescopePrompt" },
      },
      indent = {
        enable = true,
      },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      }
    }
    local vim = vim
    local opt = vim.opt

    opt.foldmethod = "expr"
    opt.foldexpr = "nvim_treesitter#foldexpr()"
    opt.foldenable = false
  else
    print('brew install tree-sitter')
  end
end
