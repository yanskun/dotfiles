return function()
	require("todo-comments").setup()

	require("which-key").register({
		["<leader>ft"] = { "<Cmd>TodoTelescope<CR>", "telescope todo comments" },
	})
end
