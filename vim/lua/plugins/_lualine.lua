require('lualine').setup({
  sections = {
    lualine_c = { 'filename', "require'lsp-status'.status()" }
  }
})
