local M = {}

local fmt = string.format

function M.conf(name)
  return require(fmt("as.plugins.%s", name))
end

return M
