return function()
  local null_ls = require('null-ls')
  local sources = { null_ls.builtins.completion.spell }

  local function exist(bin)
	  return vim.fn.exepath(bin) ~= ''
  end

  if exist('stylua') then
	  table.insert(sources, null_ls.builtins.formatting.stylua)
  end

  if exist('prettierd') then
	  table.insert(sources, null_ls.builtins.formatting.prettierd)
  end

  if exist('eslint_d') then
	  table.insert(sources, null_ls.builtins.formatting.eslint_d)
	  -- table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
  end

  null_ls.setup {
    sources = sources,
    on_attach = function(client, bufnr)
      if client.resolved_capabilities.document_formatting then
        vim.cmd([[
          augroup LspFormatting
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
          augroup END
        ]])
      end

      local wk = require('which-key')
		  wk.register({
			  q = {
				  name = 'quick',
				  f = { '<cmd>lua vim.lsp.buf.formatting_sync()<cr>', 'Format Current Buffer' },
			  },
			  K = { '<Cmd>lua vim.lsp.buf.hover()<CR>', '(LSP) Symbol Definition / Documentation' },
		  }, {
			  buffer = bufnr,
		  })
    end,
  }
end
