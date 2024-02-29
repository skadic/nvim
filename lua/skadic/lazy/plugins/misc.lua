return {
	{ "nullchilly/fsread.nvim", lazy = true, cmd = { "FSClear", "FSToggle", "FSRead" } }, -- Flow State Reading
	{ "metakirby5/codi.vim", lazy = true, ft = "python" }, -- A live coding environment
	{ "wakatime/vim-wakatime", lazy = true, event = { "BufRead" } }, -- Programming language metrics
	{
		-- Discord Rich Presence
		"andweeb/presence.nvim",
		name = "presence",
		config = function()
			local presence = require("presence")
			presence:setup()
		end,
		lazy = true,
		event = { "BufRead" },
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
		opts = {}
	},
	{
		"iamcco/markdown-preview.nvim",
		config = function()
			vim.fn["mkdp#util#install"]()
		end,
		lazy = true,
		ft = "markdown",
	},
  "stevearc/profile.nvim"
}
