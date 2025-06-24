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
		"folke/which-key.nvim",
	},
	{
		-- Telescope
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			"nvim-telescope/telescope-media-files.nvim", -- Search for media files
			"nvim-telescope/telescope-file-browser.nvim", -- A file browser
		},
		config = function()
			require("basic.telescope")
		end,
	},
	"loctvl842/monokai-pro.nvim",
  { 
    "sainnhe/sonokai",
    config = function()
      vim.g.sonokai_enable_italic = true
      vim.g.sonokai_style = 'shusia'
    end
  },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
			-- Allows you to pick windows
			{
				"s1n7ax/nvim-window-picker",
				version = "2.*",
				config = function()
					require("window-picker").setup({
						filter_rules = {
							include_current_win = false,
							autoselect_one = true,
							-- filter using buffer options
							bo = {
								-- if the file type is one of following, the window will be ignored
								filetype = { "neo-tree", "neo-tree-popup", "notify" },
								-- if the buffer type is one of following, the window will be ignored
								buftype = { "terminal", "quickfix" },
							},
						},
					})
				end,
			},
		},
		lazy = true,
		cmd = "Neotree",
		event = "BufEnter",
		opts = require("basic.neotree"),
	},
	{
		"cohama/lexima.vim",
		config = function()
			require("basic.lexima")
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				xml = { "xmlformat" },
				json = { "jq" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})

			require("lint").linters_by_ft = {
				yaml = { "yamllint" },
				lua = { "selene" },
				json = { "jsonlint" },
			}
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = require("basic.lsp.mason"),
	},
	{
		"mizlan/delimited.nvim",
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				notification = {
					override_vim_notify = true,
				},
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
}
