return function()
	require("bufferline").setup({
		options = {
			show_buffer_close_icons = false,
			show_close_icon = false,
			groups = {
				options = {
					toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
				},
				items = {
					{
						name = "Tests", -- Mandatory
						highlight = { underline = true, sp = "blue" }, -- Optional
						priority = 2, -- determines where it will appear relative to other groups (Optional)
						icon = "", -- Optional
						matcher = function(buf) -- Mandatory
							return buf.path:match("%test") or buf.path:match("%spec")
						end,
					},
					{
						name = "Docs",
						highlight = { undercurl = true, sp = "green" },
						auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
						matcher = function(buf)
							return buf.path:match("%.md") or buf.path:match("%.txt")
						end,
						separator = { -- Optional
							style = require("bufferline.groups").separator.tab,
						},
					},
				},
			},
		},
	})

	require("which-key").register({
		["<leader>gD"] = { "<Cmd>BufferLinePickClose<CR>", "bufferline: delete buffer" },
		["<leader>gb"] = { "<Cmd>BufferLinePick<CR>", "bufferline: pick buffer" },
		["<leader><Tab>"] = { "<Cmd>BufferLineCycleNext<CR>", "bufferline: next" },
		["<leader><S-Tab>"] = { "<Cmd>BufferLineCyclePrev<CR>", "bufferline: previous" },
		["<leader>gt"] = { "<Cmd>BufferLineGroupToggle Tests<CR>", "bufferline group toggle Tests" },
		["<leader>gd"] = { "<Cmd>BufferLineGroupToggle Docs<CR>", "bufferline group toggle Docs" },
		["[b"] = { "<Cmd>BufferLineMovePrev<CR>", "bufferline: move prev" },
		["]b"] = { "<Cmd>BufferLineMoveNext<CR>", "bufferline: move next" },
		["<leader>1"] = { "<Cmd>BufferLineGoToBuffer 1<CR>", "which_key_ignore" },
		["<leader>2"] = { "<Cmd>BufferLineGoToBuffer 2<CR>", "which_key_ignore" },
		["<leader>3"] = { "<Cmd>BufferLineGoToBuffer 3<CR>", "which_key_ignore" },
		["<leader>4"] = { "<Cmd>BufferLineGoToBuffer 4<CR>", "which_key_ignore" },
		["<leader>5"] = { "<Cmd>BufferLineGoToBuffer 5<CR>", "which_key_ignore" },
		["<leader>6"] = { "<Cmd>BufferLineGoToBuffer 6<CR>", "which_key_ignore" },
		["<leader>7"] = { "<Cmd>BufferLineGoToBuffer 7<CR>", "which_key_ignore" },
		["<leader>8"] = { "<Cmd>BufferLineGoToBuffer 8<CR>", "which_key_ignore" },
		["<leader>9"] = { "<Cmd>BufferLineGoToBuffer 9<CR>", "bufferline: goto 9" },
	})
end
