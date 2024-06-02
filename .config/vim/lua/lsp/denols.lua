if vim.fn.exepath("deno") ~= "" then
	vim.g.markdown_fenced_languages = {
		"ts=typescript",
	}

	local lspconfig = require("lspconfig")
	local util = require("libraries._set_lsp")

	lspconfig.denols.setup({
		cmd = { "deno", "lsp" },
		root_dir = lspconfig.util.root_pattern("deno.json", "denops"),
		on_attach = util.on_attach,
		capabilities = util.capabilities,
		flags = util.flags,
	})
else
	vim.notify("asdf install deno latest", vim.log.levels.WARN, { title = "denols" })
end
