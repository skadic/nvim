return {
	{
		"EdenEast/nightfox.nvim",
		opts = {
			options = {
				styles = {
					keywords = "bold",
					comments = "italic",
				},
			},
			modules = {
				cmp = true,
				dashboard = true,
				lsp_trouble = true,
				diagnostic = {
					enable = true,
					background = true,
				},
				native_lsp = {
					enable = true,
					background = true,
				},
				nvimtree = true,
				telescope = true,
				whichkey = true,
				symbol_outline = true,
				gitsigns = true,
			},
		},
		lazy = true,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			styles = {
				comments = { "italic" },
				keywords = { "bold" },
				booleans = { "bold" },
				functions = { "bold" },
				loops = { "bold" },
			},
		},
		lazy = true,
	},
	{ "projekt0n/github-nvim-theme", lazy = true },
	{ "dracula/vim", lazy = true },
	{ "rebelot/kanagawa.nvim", lazy = true },
	{ "jacoborus/tender.vim", lazy = true },
	{ "Shatur/neovim-ayu", lazy = true },
	{
		"navarasu/onedark.nvim",
		opts = {
			style = "darker",
			code_style = {
				keywords = "bold",
			},
		},
		lazy = true,
	},
	{ "Everblush/everblush.nvim", name = "everblush", lazy = true },
	{ "sainnhe/sonokai", lazy = true },
	{ "krfl/fleetish-vim", lazy = true },
}
