return function()
  local null = require('null-ls')
  local builtins = null.builtins
  null.setup {
    sources = {
      builtins.code_actions.gitsigns,
      builtins.formatting.prettierd,
      builtins.formatting.stylua,
      builtins.formatting.eslint_d.with({ extra_args = { "--cache" } }),
      builtins.diagnostics.eslint_d.with({ extra_args = { "--cache" } }),
      builtins.completion.spell,
    },
    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        vim.cmd([[
          augroup LspFormatting
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
          augroup END
        ]])
      end
    end,
  }
end
