local M = {}

local fmt = string.format

function M.conf(name)
	return require(fmt("plugins.%s", name))
end

function M.conf_lsp(name)
	return require(fmt("lsp.%s", name))
end

return M
