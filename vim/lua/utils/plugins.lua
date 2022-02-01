local M = {}

local fmt = string.format

function M.conf(name)
  return require(fmt("plugins.%s", name))
end

return M
