return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		event = "BufEnter",
		config = function()
			require("basic.treesitter")
		end,
	},
  {
    "aaronik/treewalker.nvim",
    lazy = true,
    cmd = "Treewalker",
    dependencies = {
		  "nvim-treesitter/nvim-treesitter",
    }
  },
	"sindrets/diffview.nvim",
	--[[ {
		"justinmk/vim-sneak",
		config = function()
			vim.g["sneak#label"] = 1
		end,
	}, ]]
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").create_default_mappings()
		end,
		dependencies = {
			"tpope/vim-repeat",
		},
	},
	{
		"folke/which-key.nvim",
		version = "*",
		opts = {
			win = {
				border = "rounded",
			},
		},
	},
	{
		-- Telescope
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
			"nvim-telescope/telescope-media-files.nvim", -- Search for media files
			"nvim-telescope/telescope-file-browser.nvim", -- A file browser
		},
		config = function()
			require("basic.telescope")
		end,
	},
	{
		"echasnovski/mini.icons",
		opts = {},
		lazy = true,
		specs = {
			{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"cohama/lexima.vim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("basic.lexima")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "echasnovski/mini.icons" },
		opts = {
			on_attach = function()
				local wk = require("which-key")
				local gs = require("gitsigns")

				wk.add({
					{ "<leader>g", group = "Git" },
					{
						"<leader>gt",
						function()
							gs.toggle_current_line_blame()
						end,
						desc = "Toggle current line blame",
					},
					{
						"<leader>gd",
						function()
							gs.diffthis("~")
						end,
						desc = "Diff",
					},
					{
						"<leader>gb",
						function()
							gs.blame_line({ full = true })
						end,
						desc = "Blame Line",
					},
				})
			end,
		},
	},
	{
		"kylechui/nvim-surround",
		lazy = true,
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
	{
		"kevinhwang91/nvim-ufo",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			require("basic.ufo")
		end,
	},
	{
		"mizlan/delimited.nvim",
		opts = {},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		config = require("basic.snacks").on_load,
    dependencies = {
      "echasnovski/mini.icons"
    }
	},
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			delete_to_trash = true,
			keymaps = {
				["<bs>"] = { "actions.parent", mode = "n" },
			},
			view_options = {
				show_hidden = true,
			},
		},
		lazy = true,
		cmd = "Oil",
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons" } },
	},
}
