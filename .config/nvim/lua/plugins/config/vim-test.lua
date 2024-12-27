return function()
  vim.cmd [[
    function! ToggleTermStrategy(cmd) abort
      call luaeval("require('toggleterm').exec(_A[1])", [a:cmd])
    endfunction

    let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
  ]]

  vim.g['test#strategy'] = 'toggleterm'
  vim.g['test#go#runner'] = 'gotest'
  vim.g['test#javascript#runner'] = 'vitest'

  require('which-key').add {
    { 't<C-f>', '<Cmd>TestFile<CR>', desc = 'run test file' },
    { 't<C-g>', '<Cmd>TestVisit<CR>', desc = 'run test last run tests' },
    { 't<C-l>', '<Cmd>TestLast<CR>', desc = 'run test last' },
    { 't<C-n>', '<Cmd>TestNearest<CR>', desc = 'run test nearest to the cursor' },
    { 't<C-s>', '<Cmd>TestSuite<CR>', desc = 'run test suite' },
  }
end
