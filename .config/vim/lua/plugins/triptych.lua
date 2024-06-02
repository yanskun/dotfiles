return function()
  require("triptych").setup()

  require("which-key").register({
    name = "triptych",
    ["<leader>-"] = { "<Cmd>Triptych<CR>", "Open Triptych, Directory browser" },
  })
end
