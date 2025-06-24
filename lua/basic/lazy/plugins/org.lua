return {
	{
		"nvim-neorg/neorg",
		lazy = false,
		version = "*",
		dependencies = {
			{ "3rd/image.nvim", opts = {} },
      { "nvim-neorg/neorg-telescope" }
		},
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					},
          ["core.export"] = {},
          ["core.export.markdown"] = {
            config = {
              extensions = { "all" }
            }
          },
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/Neorg",
							},
							default_workspace = "notes",
						},
					},
				},
			})
		end,
	},
}
