local M = {}
local lsp = require('lspconfig')
local lsputil = require('lspconfig/util')

M.setup = function()
lsp.tsserver.setup({
	settings = { documentFormatting = true },
	root_dir = function(fname)
		return lsputil.find_git_ancestor(fname) or lsputil.path.dirname(fname)
	end,
})
end

return M
