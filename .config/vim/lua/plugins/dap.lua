return function()
  require('which-key').register({
    name = 'dap',
    d = {
      b = { "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", "dap toggle breakpoint" },
      B = { "<Cmd>lua require'dap'.set_breakpoint()<CR>", "dap set breakpoint" },
      c = { "<Cmd>lua require'dap'.continue()<CR>", "dap continue debugging" },
      e = { "<Cmd>lua require'dap'.step_out()<CR>", "dap step out" },
      i = { "<Cmd>lua require'dap'.step_into()<CR>", "dap step into" },
      o = { "<Cmd>lua require'dap'.step_over()<CR>", "dap step over" },
      l = { "<Cmd>lua require'dap'.run_last()<CR>", "dap run last" },
      s = { "<Cmd>lua require'dap'.list_breakpoints()<CR>", "dap show breakpoints" },
      g = { "<Cmd>lua require('dap-go').debug_test()<CR>", "dap go debug test" },
      C = { "<Cmd>lua require'dap'.clear_breakpoints()<CR>", "dap remove all breakpoints" }
    },
  }, {
    prefix = '<leader>'
  })

  local fn = vim.fn

  fn.sign_define('DapBreakpoint', { text = '⛔️', texthl = '', linehl = '', numhl = '' })
  fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })
end
