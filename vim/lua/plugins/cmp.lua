return function()

  local cmp = require('cmp')

  cmp.setup({
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-q>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior }),
      ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior }),
      ['<UP>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior }),
      ['<DOWN>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior })
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
    }),
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end
    }
  })

  vim.cmd([[
    autocmd FileType TelescopePrompt,NvimTree,netrw lua require'cmp'setup.buffer {
    \   completion = { autocomplete = false }
    \ }
  ]])
end
