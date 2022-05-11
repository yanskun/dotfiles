return function()
  local nvim_lsp = require('lspconfig')
  local lsp_installer = require("nvim-lsp-installer")

  local utils = require('libraries._set_config')
  local conf_lsp = utils.conf_lsp

  vim.diagnostic.config({
    virtual_text = false
  })
  vim.o.updatetime = 250
  vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

  -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  --   vim.lsp.diagnostic.on_publish_diagnostics, {
  --     underline = true,
  --     virtual_text = {
  --       spacing = 4,
  --       prefix = ''
  --     }
  --   }
  -- )

  local servers = {
    'denols',
    'eslint',
    'gopls',
    'jsonls',
    'sumneko_lua',
    'tflint',
    'tsserver',
    'vuels',
    'yamlls',
  }

  for _, lsp in ipairs(servers) do
    conf_lsp(lsp)
  end


  -- Switching between tsserver and denols
  local node_root_dir = nvim_lsp.util.root_pattern("package.json", "node_modules")
  local buf_name = vim.api.nvim_buf_get_name(0)
  local current_buf = vim.api.nvim_get_current_buf()
  local is_node_repo = node_root_dir(buf_name, current_buf) ~= nil

  lsp_installer.on_server_ready(function(server)
    local opts = {}

    if server.name == "tsserver" or server.name == "eslint" then
      opts.autostart = is_node_repo
    elseif server.name == "denols" then
      opts.autostart = not(is_node_repo)
      opts.init_options = {
        lint = true,
        unstable = true,
      }
    end
    server:setup(opts)

  end)
end
