if vim.fn.exepath("tailwindcss-language-server") ~= "" then
	local lspconfig = require("lspconfig")
	local util = require("libraries._set_lsp")

	lspconfig.tailwindcss.setup({
		on_attach = util.on_attach,
		capabilities = util.capabilities,
		flags = util.flags,
	})
else
	vim.notify("npm install -g @tailwindcss/language-server", vim.log.levels.WARN, { title = "tailwindcss" })
end
