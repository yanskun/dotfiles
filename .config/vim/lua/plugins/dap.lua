return function()
  require('which-key').register({
    name = 'dap',
    d = {
      b = { "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", "dap toggle breakpoint" },
      B = { "<Cmd>lua require'dap'.set_breakpoint()<CR>", "dap set breakpoint" },
      c = { "<Cmd>lua require'dap'.continue()<CR>", "dap continue debugging" },
      L = { "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
        "dap set info breakpoint" },
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

  vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e55561', bold = true })
  vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#e2b86b' })
  vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#4fa6ed' })

  fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
  fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = '', numhl = '' })
  fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = '', numhl = '' })
end
