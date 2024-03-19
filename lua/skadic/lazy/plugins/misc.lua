return {
	{ "nullchilly/fsread.nvim", lazy = true, cmd = { "FSClear", "FSToggle", "FSRead" } }, -- Flow State Reading
	{ "metakirby5/codi.vim", lazy = true, ft = "python" }, -- A live coding environment
	{ "wakatime/vim-wakatime", lazy = true, event = { "BufRead" } }, -- Programming language metrics
	{
		-- Discord Rich Presence
		"andweeb/presence.nvim",
		name = "presence",
		enabled = false,
		config = function()
			local presence = require("presence")
			presence:setup()
		end,
		lazy = true,
		event = { "BufRead" },
	},
	{
		"IogaMaster/neocord",
		lazy = true,
		event = "VeryLazy",
		opts = {},
	},
	{
		-- Zen-Mode for Neorg's presenter
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup()
		end,
		enabled = false,
		lazy = true,
		cmd = "ZenMode",
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = true,
		event = "BufRead",
		opts = {},
	},
	{
		"mizlan/delimited.nvim",
		lazy = true,
		opts = {
			pre = function()
				-- do something here
			end,
			post = function()
				-- do something here
			end,
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		config = function()
			vim.fn["mkdp#util#install"]()
		end,
		lazy = true,
		ft = "markdown",
	},
	{
		"ggandor/lightspeed.nvim",
		opts = {},
	},
}
