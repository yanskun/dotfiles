return function()
  require('dapui').setup()

  require('which-key').register({
    d = {
      u = {
        name = 'dapui',
        c = { "<Cmd>lua require'dapui'.close()<CR>", "dapui close" },
        o = { "<Cmd>lua require'dapui'.open()<CR>", "dapui open" },
      }
    }
  }, {
    prefix = '<leader>',
  }
  )
end
