return function()
  vim.opt.termguicolors = true

  require('bufferline').setup({
    options = {
      show_buffer_close_icons = false,
      show_close_icon = false,
    }
  })

  require('which-key').register {
    ['<leader>gD'] = { '<Cmd>BufferLinePickClose<CR>', 'bufferline: delete buffer' },
    ['<leader>gb'] = { '<Cmd>BufferLinePick<CR>', 'bufferline: pick buffer' },
    ['<leader><Tab>'] = { '<Cmd>BufferLineCycleNext<CR>', 'bufferline: next' },
    ['<leader><S-Tab>'] = { '<Cmd>BufferLineCyclePrev<CR>', 'bufferline: previous' },
    ['[b'] = { '<Cmd>BufferLineMoveNext<CR>', 'bufferline: move next' },
    [']b'] = { '<Cmd>BufferLineMovePrev<CR>', 'bufferline: move prev' },
    ['<leader>1'] = { '<Cmd>BufferLineGoToBuffer 1<CR>', 'which_key_ignore' },
    ['<leader>2'] = { '<Cmd>BufferLineGoToBuffer 2<CR>', 'which_key_ignore' },
    ['<leader>3'] = { '<Cmd>BufferLineGoToBuffer 3<CR>', 'which_key_ignore' },
    ['<leader>4'] = { '<Cmd>BufferLineGoToBuffer 4<CR>', 'which_key_ignore' },
    ['<leader>5'] = { '<Cmd>BufferLineGoToBuffer 5<CR>', 'which_key_ignore' },
    ['<leader>6'] = { '<Cmd>BufferLineGoToBuffer 6<CR>', 'which_key_ignore' },
    ['<leader>7'] = { '<Cmd>BufferLineGoToBuffer 7<CR>', 'which_key_ignore' },
    ['<leader>8'] = { '<Cmd>BufferLineGoToBuffer 8<CR>', 'which_key_ignore' },
    ['<leader>9'] = { '<Cmd>BufferLineGoToBuffer 9<CR>', 'bufferline: goto 9' },
  }
end
