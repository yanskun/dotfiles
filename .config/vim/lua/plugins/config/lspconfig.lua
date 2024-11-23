return function()
  local utils = require("libraries._set_config")
  local conf_lsp = utils.conf_lsp

  vim.diagnostic.config({
    virtual_text = false,
  })
  vim.o.updatetime = 250

  -- mapping
  require("which-key").add({
    { "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Show diagnostics in a floating window" },
    {
      "<space>q",
      "<cmd>lua vim.diagnostic.setloclist()<CR>",
      desc = "Add buffer diagnostics to the location list",
    },
    {
      "[d",
      "<cmd>lua vim.diagnostic.goto_prev()<CR>",
      desc = "Move to the previous diagnostic in the current buffer",
    },
    { "]d",       "<cmd>lua vim.diagnostic.goto_next()<CR>",  desc = "Move to the next diagnostic" },
    { "K",        "<cmd>lua vim.lsp.buf.hover()<CR>",         desc = "Show hover doc" },
    { "ga",       "<cmd>lua vim.lsp.buf.code_action()<CR>",   desc = "Code Action" },
    { "gsr",      "<cmd>lua vim.lsp.buf.rename()<CR>",        desc = "Rename" },
  })

  local servers = {
    "buf_ls",
    "biome",
    "cssls",
    "denols",
    "gopls",
    "jsonls",
    "lua_ls",
    "prismals",
    "pylsp",
    "ruby_lsp",
    "rust_analyzer",
    "sqlls",
    "svelte",
    "tailwindcss",
    "tflint",
    "ts_ls",
    "volar",
    "yamlls",
    "zls",
  }

  for _, lsp in ipairs(servers) do
    conf_lsp(lsp)
  end

  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    command = [[ lua vim.diagnostic.open_float(nil, {focus=false}) ]],
  })
end