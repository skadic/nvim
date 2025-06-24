return {
	"neovim/nvim-lspconfig",
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("basic.lsp.mason-lspconfig")
		end,
	},
	{
		"aznhe21/actions-preview.nvim",
		lazy = true,
	},
}
