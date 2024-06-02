-- stylua
-- cmd: cargo install stylua
-- src: https://github.com/JohnnyMorganz/StyLua

return function()
	if vim.fn.executable("stylua") == "" then
		vim.notify("cargo install stylua", vim.log.levels.WARN, { title = "cargo install stylua" })
	end

	local null_ls = require("null-ls")

	local lsp_formatting = function(bufnr)
		vim.lsp.buf.format({
			filter = function(client)
				-- apply whatever logic you want (in this example, we'll only use null-ls)
				return client.name == "null-ls" or client.name ~= "tsserver"
			end,
			bufnr = bufnr,
			timeout = 1000,
		})
	end

	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	local on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end

	local sources = {
		null_ls.builtins.formatting.prettierd.with({
			filetypes = { "html", "javascript", "json", "typescript", "yaml", "markdown" },
		}),
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.completion.spell,
		require("none-ls.diagnostics.eslint"),
		require("none-ls.diagnostics.flake8"),
		require("none-ls-shellcheck.diagnostics").with({ extra_filetypes = { "envrc", "env" } }),
		require("none-ls-shellcheck.code_actions").with({ extra_filetypes = { "envrc", "env" } }),
		null_ls.builtins.diagnostics.vacuum,
		null_ls.builtins.formatting.black,
		require("none-ls.formatting.eslint_d").with({
			filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
		}),
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
		}),
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.markuplint.with({
			filetypes = { "html", "vue" },
		}),
	}

	null_ls.setup({
		sources = sources,
		on_attach = on_attach,
	})
end
