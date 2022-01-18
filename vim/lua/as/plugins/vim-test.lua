return function()
  vim.cmd([[
    let test#strategy = "neovim"
    let test#go#runner = 'gotest'
  ]])

  require('which-key').register {
    t = {
      ['<C-n>'] = { '<Cmd>TestNearest<CR>', 'run test nearest to the cursor' },
      ['<C-f>'] = { '<Cmd>TestFile<CR>', 'run test file' },
      ['<C-s>'] = { '<Cmd>TestSuite<CR>', 'run test suite' },
      ['<C-l>'] = { '<Cmd>TestLast<CR>', 'run test last' },
      ['<C-g>'] = { '<Cmd>TestVisit<CR>', 'run test last run tests' },
    }
  }
end
