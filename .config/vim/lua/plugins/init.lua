local utils = require("libraries._set_config")

local conf = utils.conf

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
	"nvim-lua/plenary.nvim",

	-- "github/copilot.vim",
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			debug = true, -- Enable debugging
			-- See Configuration section for rest
		},
		config = conf("copilot-chat"),
		-- See Commands section for default commands if you want to lazy load on them
	},

	-- TODO: suggest suport
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	config = conf("noice"),
	-- },

	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				plugins = {
					tmux = { enabled = true },
					alacritty = { enabled = true, font = 15 },
				},
			})
		end,
	},

	{
		"navarasu/onedark.nvim",
		config = conf("onedark"),
		lazy = false,
		priority = 1000,
	},

	{
		"mcauley-penney/visual-whitespace.nvim",
		config = true,
	},

	{
		"petertriho/nvim-scrollbar",
		config = conf("nvim-scrollbar"),
	},

	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
			vim.notify = require("notify")
		end,
	},

	-- git
	{
		"NeogitOrg/neogit",
		config = true,
	},
	{
		"nvim-lua/plenary.nvim", -- required
		lazy = true,
	},
	{
		"sindrets/diffview.nvim", -- optional - Diff integration
		config = conf("diffview"),
		lazy = true,
	},
	{
		"ibhagwan/fzf-lua", -- optional
		lazy = true,
	},

	{
		"f-person/git-blame.nvim",
		config = function()
			vim.g.gitblame_message_template = "<summary> | <date> | <author>"
			vim.g.gitblame_ignored_filetypes = { "NvimTree", "neo-tree" }
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = conf("gitsigns"),
	},

	-- {
	--   "sindrets/diffview.nvim",
	--   config = conf("diffview"),
	-- },

	"tpope/vim-fugitive",

	"tpope/vim-rhubarb",

	-- key mapping
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup()
		end,
	},
	{
		"echasnovski/mini.icons",
	},
	{
		"nvim-tree/nvim-web-devicons",
	},

	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		config = conf("telescope"),
	},
	{
		"nvim-telescope/telescope-symbols.nvim",
	},
	{
		"hrsh7th/nvim-cmp",
	},
	{
		"jonarrien/telescope-cmdline.nvim",
	},

	{
		"fdschmidt93/telescope-egrepify.nvim",
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
	},

	{
		"simonmclean/triptych.nvim",
		event = "VeryLazy",
		config = conf("triptych"),
	},

	{
		"folke/todo-comments.nvim",
		config = conf("todo-comments"),
	},

	-- explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = false,
		priority = 100,
		config = conf("neo-tree"),
	},
	{
		"MunifTanjim/nui.nvim",
	},
	{
		"kyazdani42/nvim-web-devicons",
	},
	{
		"s1n7ax/nvim-window-picker",
		-- "yanskun/nvim-window-picker",
		commit = "6e9875711b9d5cefcf77cc6e30dcce53135b9cc5",
		config = conf("nvim-window-picker"),
	},

	-- wildmenu
	{
		"gelguy/wilder.nvim",
		config = conf("wilder"),
	},

	-- buffer
	{
		"akinsho/bufferline.nvim",
		config = conf("bufferline"),
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		config = conf("treesitter"),
		build = ":TSUpdate",
	},
	{
		dir = "~/Projects/github.com/yanskun/nvim-treesitter-context",
		-- "yanskun/nvim-treesitter-context",
		config = conf("treesitter-context"),
	},

	-- snippets
	{
		"L3MON4D3/LuaSnip",
		config = conf("luasnip"),
	},
	{ "rafamadriz/friendly-snippets" },

	-- lsp
	{
		"neovim/nvim-lspconfig",
		config = conf("lspconfig"),
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"RRethy/vim-illuminate",
	},

	{
		"williamboman/mason.nvim",
		config = conf("mason"),
	},
	-- none-ls
	{
		"nvimtools/none-ls.nvim",
		config = conf("null-ls"),
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = conf("mason-lspconfig"),
	},
	{
		"nvimtools/none-ls-extras.nvim",
	},
	{
		"gbprod/none-ls-shellcheck.nvim",
	},

	-- {
	--   "kkharji/lspsaga.nvim",
	--   config = conf("lspsaga"),
	-- },

	{
		"akinsho/flutter-tools.nvim",
		config = conf("flutter-tools"),
		ft = "dart",
	},

	{
		"onsails/diaglist.nvim",
		config = conf("diaglist"),
	},

	-- autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = conf("cmp"),
	},
	{ "hrsh7th/cmp-nvim-lsp", after = "nvim-lspconfig" },
	{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
	{ "hrsh7th/cmp-path", after = "nvim-cmp" },
	{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
	{ "f3fora/cmp-spell", after = "nvim-cmp" },
	{ "hrsh7th/cmp-vsnip", after = "nvim-cmp" },
	{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
	{ "petertriho/cmp-git", after = "nvim-cmp" },
	{
		"zbirenbaum/copilot-cmp",
		after = { "nvim-cmp", "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{ "saadparwaiz1/cmp_luasnip" },
	{ "onsails/lspkind.nvim" },

	-- testings
	{
		"vim-test/vim-test",
		config = conf("vim-test"),
	},
	{
		"akinsho/toggleterm.nvim",
	},

	{
		"nvim-neotest/neotest",
		config = conf("neotest"),
	},
	{
		"antoinemadec/FixCursorHold.nvim",
	},
	-- Neotest Adapters
	"marilari88/neotest-vitest",

	{
		"mfussenegger/nvim-dap",
		config = conf("dap"),
	},
	{
		"rcarriga/nvim-dap-ui",
		config = conf("dapui"),
	},
	"nvim-neotest/nvim-nio",
	-- dap Adaptars
	"mxsdev/nvim-dap-vscode-js",
	"leoluz/nvim-dap-go",

	-- development
	-- brackets
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				close_triple_quotes = true,
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		-- :h nvim-surround.usage
	},

	-- code snapshot
	{
		"ellisonleao/carbon-now.nvim",
		lazy = true,
		cmd = { "CarbonNow" },
		config = function()
			require("carbon-now").setup({
				open_cmd = "open",
			})
		end,
	},

	-- tag
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- comment
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- indent
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({
				scope = {
					show_start = false,
				},
			})
		end,
	},

	-- terminal
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				direction = "horizontal",
				start_in_insert = false,
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return math.floor(vim.o.columns * 0.4)
					end
				end,
			})
		end,
	},

	-- color
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- match info
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()
		end,
	},

	-- status line
	{
		"nvim-lualine/lualine.nvim",
		config = conf("lualine"),
	},
	{
		"nvim-lua/lsp-status.nvim",
	},

	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
	},

	-- launguages support
	-- go
	{
		"ray-x/go.nvim",
		ft = "go",
		config = function()
			require("go").setup()
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function()
					require("go.format").goimport()
				end,
			})
		end,
	},
	{
		"yanskun/gotests.nvim",
		ft = "go",
		config = function()
			require("gotests").setup()
		end,
	},
	{ "ray-x/guihua.lua" },

	-- Rust
	{
		"rust-lang/rust.vim",
		ft = "rust",
		config = conf("rust"),
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		config = function()
			require("rust-tools").setup({
				hover_with_actions = false,
			})
		end,
	},

	-- Zig
	{
		"ziglang/zig.vim",
		ft = { "zig", "zir" },
	},

	-- deno
	-- "vim-denops/denops.vim",
	-- "yanskun/dps-translate.nvim",
	-- markdown
	{
		"ellisonleao/glow.nvim",
		config = true,
		cmd = "Glow",
	},

	"yanskun/change-case.nvim",

	-- WakaTime
	"wakatime/vim-wakatime",

	-- props
	"dstein64/vim-startuptime",
})
