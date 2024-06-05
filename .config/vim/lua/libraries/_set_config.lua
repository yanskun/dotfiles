local M = {}

local fmt = string.format

function M.conf(name)
  return require(fmt("plugins.%s", name))
end

function M.conf_lsp(name)
  return require(fmt('lsp.%s', name))
end

function M.lsp_file_exists(name)
  local f = io.open(name, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

return M
