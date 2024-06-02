return function()
	require("which-key").register({
		K = { "<Cmd>Lspsaga hover_doc<CR>", "lspsaga show hover doc" },
		["gs"] = {
			name = "lspsaga",
			r = { "<Cmd>Lspsaga rename<CR>", "lspsaga rename" },
			a = { "<Cmd>Lspsaga code_action<CR>", "lspsaga codeaction" },
		},
	}, {
		silent = true,
	})

	require("which-key").register({
		["gs"] = {
			name = "lspsaga",
			a = { "<Cmd><C-U>Lspsaga range_code_action<CR>", "lspsaga range codeaction" },
		},
	}, {
		mode = "v",
		silent = true,
	})
end
