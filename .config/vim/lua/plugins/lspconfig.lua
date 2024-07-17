return function()
  local utils = require("libraries._set_config")
  local conf_lsp = utils.conf_lsp

  local default_config = require("lsp.default")

  vim.diagnostic.config({
    virtual_text = false,
  })
  vim.o.updatetime = 250

  -- mapping
  require("which-key").add({
    { "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Show diagnostics in a floating window" },
    { "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "Add buffer diagnostics to the location list" },
    { "[d",       "<cmd>lua vim.diagnostic.goto_prev()<CR>",  desc = "Move to the previous diagnostic in the current buffer" },
    { "]d",       "<cmd>lua vim.diagnostic.goto_next()<CR>",  desc = "Move to the next diagnostic" },
  })

  local servers = {
    "biome",
    "cssls",
    "denols",
    "gopls",
    "jsonls",
    "lua_ls",
    "pylsp",
    "ruby_lsp",
    "rust_analyzer",
    "sqlls",
    "svelte",
    "tailwindcss",
    "tflint",
    "tsserver",
    "volar",
    "yamlls",
    "zls",
  }

  for _, lsp in ipairs(servers) do
    if utils.lsp_file_exists(lsp) then
      conf_lsp(lsp)
    else
      default_config(lsp)
    end
  end

  vim.api.nvim_create_autocmd(
    { "CursorHold", "CursorHoldI" },
    {
      pattern = "*",
      command = [[ lua vim.diagnostic.open_float(nil, {focus=false}) ]],
    }
  )
end
