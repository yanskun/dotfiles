return function()
  require('which-key').add({
    { '<space>d', group = 'diagnostics' },
    { '<space>d0', "<cmd>lua require('diaglist').open_buffer_diagnostics()<CR>", desc = 'Open buffer diagnostics' },
    { '<space>dw', "<cmd>lua require('diaglist').open_all_diagnostics()<CR>", desc = 'Open all diagnostics' },
  })
end
