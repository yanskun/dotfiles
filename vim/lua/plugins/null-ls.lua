return function()
  local null_ls = require('null-ls')
  null_ls.setup {
    sources = {
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.eslint,
      null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.completion.spell,
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
