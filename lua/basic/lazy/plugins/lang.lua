return {
	{
		"mrcjkb/rustaceanvim",
		lazy = true,
		ft = "rust",
		version = "^5", -- Recommended
	},
	{
		"vxpm/ferris.nvim",
		lazy = true,
		ft = "rust",
		opts = {
			-- your options here
		},
	},
	{
		"nvim-java/nvim-java",
		lazy = true,
		ft = "java",
		config = function()
			require("basic.lsp.settings.jdtls")
		end,
	},
	{
		"rcasia/neotest-java",
		ft = "java",
		dependencies = {
			"mfussenegger/nvim-jdtls",
			"mfussenegger/nvim-dap", -- for the debugger
			"rcarriga/nvim-dap-ui", -- recommended
			"theHamsta/nvim-dap-virtual-text", -- recommended
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "mini.icons", words = { "MiniIcons" } },
			},
		},
	},
}
