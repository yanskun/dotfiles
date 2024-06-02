local util = require("lspconfig.util")
require("lspconfig").zls.setup({
	cmd = { "zls" },
	filetypes = { "zig", "zir" },
	root_dir = util.root_pattern("zls.json", ".git"),
	single_file_support = true,
})
