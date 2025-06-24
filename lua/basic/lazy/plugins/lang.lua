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
    end
	},
}
