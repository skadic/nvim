return {
	{
		"harrisoncramer/gitlab.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
			"nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
		},
		build = function()
			require("gitlab.server").build(true)
		end, -- Builds the Go binary
		config = function()
			require("gitlab").setup()
		end,
    keys = {
      { "<leader>Gm", function() require("gitlab").choose_merge_request() end, desc = "Choose Merge Request" },
      { "<leader>Gr", function() require("gitlab").review() end, desc = "Review" },
      { "<leader>Gc", function() require("gitlab").create_comment() end, desc = "Create Comment" }
    }
	},
}
