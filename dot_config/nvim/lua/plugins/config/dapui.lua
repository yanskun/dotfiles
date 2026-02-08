return function()
  require('dapui').setup()

  require('which-key').add({
    { '<leader>du', group = 'dapui' },
    { '<leader>duc', "<Cmd>lua require'dapui'.close()<CR>", desc = 'dapui close' },
    { '<leader>duo', "<Cmd>lua require'dapui'.open()<CR>", desc = 'dapui open' },
    { '<leader>dut', "<Cmd>lua require'dapui'.toggle()<CR>", desc = 'dapui toggle' },
  })
end
