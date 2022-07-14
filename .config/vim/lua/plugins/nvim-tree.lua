return function()
  local ok, nvimtree = pcall(require, "nvim-tree")

  if not ok then
    return
  end

  nvimtree.setup({
    disable_netrw = false,
    hijack_netrw = true,
    hijack_cursor = true,
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    git = {
      enable = true,
      ignore = false,
    },
  })

  require("which-key").register({
    ["<leader>t"] = { "<Cmd>Neotree reveal toggle<CR>", "nvim tree open / close toggle" },
    ["<leader>e"] = { "<Cmd>Neotree reveal<CR>", "nvim tree focus current file" },
  })
end
