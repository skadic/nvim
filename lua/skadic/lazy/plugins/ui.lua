return {
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
		opts = require("skadic.neo-tree"),
	},
	{
		-- Nice statusbar
		"freddiehaddad/feline.nvim",
		name = "feline",
		dependencies = {
			"SmiteshP/nvim-navic",
		},
		config = function()
			require("feline").setup(require("skadic.feline_conf").bar)
			require("feline").winbar.setup(require("skadic.feline_conf").winbar)
		end,
	},
	{
		"SmiteshP/nvim-navic",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("nvim-navic").setup(require("skadic.navic"))
		end,
	},
	{
		-- Allows to see keybinds
		"folke/which-key.nvim",
		opts = {
      win = {
        border = "rounded"
      }
    },
		lazy = true,
	},

	--- LSP-Related UI ---
	{
		"SmiteshP/nvim-navbuddy",
		lazy = true,
		dependencies = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lsp = {
				auto_attach = true,
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				notification = {
					override_vim_notify = true,
					window = {
						winblend = 0, -- Background color opacity in the notification window
					},
				},
			})
		end,
	},
	{
		-- Debugger UI
		"rcarriga/nvim-dap-ui",
		lazy = true,
		enabled = false,
		event = "LspAttach",
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"aznhe21/actions-preview.nvim",
		lazy = true,
		event = "LspAttach",
		config = function()
			require("actions-preview").setup({
				highlight_command = { require("actions-preview.highlight").delta() },
			})
		end,
	},
	{
		"andythigpen/nvim-coverage",
		config = true,
		lazy = true,
		event = "LspAttach",
	},
}
