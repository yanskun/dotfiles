return function()
  require('todo-comments').setup()

  require('which-key').add {
    { "<leader>ft", "<Cmd>TodoTelescope<CR>", desc = "telescope todo comments" },
  }
end
