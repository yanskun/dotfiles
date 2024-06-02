return function()
  require("which-key").register({
    d = {
      name = "+diagnostics",
      w = { "<cmd>lua require('diaglist').open_all_diagnostics()<CR>", "Open all diagnostics" },
      ["0"] = { "<cmd>lua require('diaglist').open_buffer_diagnostics()<CR>", "Open buffer diagnostics" },
    }
  }, {
    prefix = "<space>"
  })
end
