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
			highlight_overrides = {
				mocha = function(colors)
					return {
						Comment = { fg = colors.overlay0 },
						LineNr = { fg = colors.overlay0 },
						LspInlayHint = { fg = colors.overlay1, bg = "NONE" },
					}
				end,
			},
			styles = {
				comments = { "italic" },
				keywords = { "bold" },
				booleans = { "bold" },
				functions = { "bold" },
				loops = { "bold" },
			},
			integrations = {
				cmp = true,
				gitsigns = false,
				nvimtree = true,
				treesitter = true,
				notify = true,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				fidget = true,
				neotree = true,
				navic = {
					enabled = false,
					custom_bg = "NONE", -- "lualine" will set background to mantle
				},
				which_key = true,
				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
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
