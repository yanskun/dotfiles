return function()

  local cmp = require('cmp')
  local lspkind = require('lspkind')

  cmp.setup({
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-q>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<UP>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior }),
      ['<DOWN>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior })
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'vsnip' },
    }),
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end
    },
    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        maxwidth = 50,
        before = function(entry, vim_item)
          return vim_item
        end
      })
    },
    window = {
      completion = {
        border = 'rounded',
        scrollbar = '║',
      },
      documentation = {
        border = 'rounded',
        scrollbar = '',
      },
    }
  })

  vim.cmd([[
    autocmd FileType TelescopePrompt,NvimTree,netrw lua require'cmp'setup.buffer {
    \   completion = { autocomplete = false }
    \ }
  ]])
end
