local M = {}

local fmt = string.format

local default_config = require("lsp.default")

function M.conf(name)
	return require(fmt("plugins.%s", name))
end

function M.conf_lsp(name)
	local ok, _ = pcall(require, fmt("lsp.%s", name))

	if not ok then
		default_config(name)
	end
end

return M
