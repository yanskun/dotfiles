local lspconfig = require("lspconfig")
local util = require("libraries._set_lsp")

lspconfig.sqlls.setup({
	root_dir = lspconfig.util.root_pattern(".git"),
	filetypes = { "sql" },
	on_attach = util.on_attach,
	capabilities = util.capabilities,
	flags = util.flags,
})
