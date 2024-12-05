return function()
  require('which-key').add({
    { '<leader>d', group = 'dap' },
    {
      '<leader>dB',
      "<Cmd>lua require'dap'.set_breakpoint()<CR>",
      desc = 'dap set breakpoint',
    },
    {
      '<leader>dC',
      "<Cmd>lua require'dap'.clear_breakpoints()<CR>",
      desc = 'dap remove all breakpoints',
    },
    {
      '<leader>dL',
      "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
      desc = 'dap set info breakpoint',
    },
    {
      '<leader>db',
      "<Cmd>lua require'dap'.toggle_breakpoint()<CR>",
      desc = 'dap toggle breakpoint',
    },
    {
      '<leader>dc',
      "<Cmd>lua require'dap'.continue()<CR>",
      desc = 'dap continue debugging',
    },
    {
      '<leader>de',
      "<Cmd>lua require'dap'.step_out()<CR>",
      desc = 'dap step out',
    },
    {
      '<leader>di',
      "<Cmd>lua require'dap'.step_into()<CR>",
      desc = 'dap step into',
    },
    {
      '<leader>dl',
      "<Cmd>lua require'dap'.run_last()<CR>",
      desc = 'dap run last',
    },
    {
      '<leader>do',
      "<Cmd>lua require'dap'.step_over()<CR>",
      desc = 'dap step over',
    },
    {
      '<leader>ds',
      "<Cmd>lua require'dap'.list_breakpoints()<CR>",
      desc = 'dap show breakpoints',
    },

    {
      '<leader>dg',
      function()
        local buf = vim.api.nvim_get_current_buf()
        local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if ft == 'go' then
          require('dap-go').debug_test()
        else
          require('neotest').run.run({ vim.fn.expand('%'), vitestCommand = 'vitest --watch' })
        end
      end,
      desc = 'dap go debug test',
    },
  })

  local fn = vim.fn

  vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e55561', bold = true })
  vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#e2b86b' })
  vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#4fa6ed' })

  fn.sign_define('DapBreakpoint', { text = '󰄳', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
  fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = '', numhl = '' })
  fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = '', numhl = '' })

  -- Adaptars
  require('dap-go').setup()
  require('dap-vscode-js').setup({
    debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
    debugger_cmd = { 'js-debug-adapter' },
    adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
  })
end
