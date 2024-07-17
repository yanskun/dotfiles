return function()
  require('which-key').add({
    { "<leader>gc", "<Cmd>DiffviewClose<CR>", desc = "diff view close" },
    { "<leader>go", "<Cmd>DiffviewOpen<CR>",  desc = "diff view open" },
  })
end
