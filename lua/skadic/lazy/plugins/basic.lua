return {
	"folke/lazy.nvim", -- Have lazy manage itself
  "rktjmp/hotpot.nvim", -- Have Lazymanage hotpot
	{ "nvim-lua/popup.nvim", lazy = true }, -- An implementation of the Popup API from vim in Neovim
	{ "nvim-lua/plenary.nvim", lazy = true }, -- Useful lua functions used ny lots of plugins
	{
		-- Git Commands
		"lewis6991/gitsigns.nvim",
		lazy = true,
		cmd = "Gitsigns",
		enabled = false,
		config = function()
			require("skadic.gitsigns")
		end,
	},
	{
		"mhinz/vim-signify",
		config = function()
			require("skadic.vim_signify")
		end,
	},
	{
		-- Telescope
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-media-files.nvim", -- Search for media files
			"nvim-telescope/telescope-file-browser.nvim", -- A file browser
			"gbrlsnchs/telescope-lsp-handlers.nvim", -- Better LSP Functions
			"HUAHUAI23/telescope-session.nvim",
		},
		config = function()
			require("skadic.telescope")
		end,
	},
	{
		-- A native Sorter for telescope to increase performance
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		lazy = true,
	},
	{
		-- Modify surrounding symbols
		"kylechui/nvim-surround",
		config = true,
		lazy = true,
		keys = { "ys", "ds", "cs" },
	},
	{
		-- Auto-close parentheses
		"windwp/nvim-autopairs",
		lazy = true,
		event = { "BufRead" },
		config = function()
			require("skadic.autopairs")
			--require("nvim-autopairs").setup({})
		end,
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
	},
	{
		-- nice folding
		"kevinhwang91/nvim-ufo",
		lazy = true,
		keys = { "z", mode = "n" },
		config = function()
			require("skadic.ufo")
		end,
		dependencies = {
			"kevinhwang91/promise-async",
		},
	},
	{ "famiu/bufdelete.nvim", lazy = true, cmd = { "Bdelete" } }, -- Allow better deletion of buffers
}
