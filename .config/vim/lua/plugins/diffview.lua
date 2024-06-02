return function()
	require("which-key").register({
		g = {
			o = { "<Cmd>DiffviewOpen<CR>", "diff view open" },
			c = { "<Cmd>DiffviewClose<CR>", "diff view close" },
		},
	}, {
		prefix = "<leader>",
	})
end
