return function()
  local utils = require("libraries._set_config")
  local conf_lsp = utils.conf_lsp

  vim.diagnostic.config({
    virtual_text = false,
  })
  vim.o.updatetime = 250

  -- mapping
  require("which-key").register({
    name = "lsp",
    ["<space>e"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show diagnostics in a floating window" },
    ["[d"] = {
      "<cmd>lua vim.diagnostic.goto_prev()<CR>",
      "Move to the previous diagnostic in the current buffer",
    },
    ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Move to the next diagnostic" },
    ["<space>q"] = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Add buffer diagnostics to the location list" },
  })

  local servers = require("lsp.servers")

  for _, lsp in ipairs(servers) do
    conf_lsp(lsp)
  end

  vim.api.nvim_create_autocmd(
    "CursorHold,CursorHoldI",
    {
      pattern = "*",
      command = [[ lua vim.diagnostic.open_float(nil, {focus=false}) ]],
    }
  )
end
