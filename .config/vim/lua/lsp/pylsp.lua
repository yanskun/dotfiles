if vim.fn.exepath("pylsp") ~= "" then
	local lspconfig = require("lspconfig")
	local util = require("libraries._set_lsp")

	lspconfig.pylsp.setup({
		on_attach = util.on_attach,
		capabilities = util.capabilities,
		flags = util.flags,
	})
else
	vim.notify("pip install python-lsp-server", vim.log.levels.WARN, { title = "servername" })
end
