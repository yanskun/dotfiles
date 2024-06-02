return function()
  vim.cmd [[
    function! ToggleTermStrategy(cmd) abort
      call luaeval("require('toggleterm').exec(_A[1])", [a:cmd])
    endfunction

    let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
  ]]

  vim.g['test#strategy'] = 'toggleterm'
  vim.g['test#go#runner'] = 'gotest'

  require('which-key').register {
    name = 'test',
    t = {
      ['<C-n>'] = { '<Cmd>TestNearest<CR>', 'run test nearest to the cursor' },
      ['<C-f>'] = { '<Cmd>TestFile<CR>', 'run test file' },
      ['<C-s>'] = { '<Cmd>TestSuite<CR>', 'run test suite' },
      ['<C-l>'] = { '<Cmd>TestLast<CR>', 'run test last' },
      ['<C-g>'] = { '<Cmd>TestVisit<CR>', 'run test last run tests' },
    }
  }
end
