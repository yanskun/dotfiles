local M = {}

local fmt = string.format

function M.conf(name)
  return require(fmt("plugins.%s", name))
end

function M.conf_lsp(name)
  if (package.loaded[fmt('lsp.%s', name)]) then
    return require(fmt('lsp.%s', name))
  else
    vim.api.command(fmt('not found config file %s', name))
  end
end

return M
