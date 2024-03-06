return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers", -- This is the important bit!
		config = true,
		lazy = true,
		enabled = false,
		ft = "neorg",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neorg/neorg-telescope",
			"max397574/neorg-kanban",
			"max397574/neorg-contexts",
		},
	},
	{
		"nvim-orgmode/orgmode",
		lazy = true,
		ft = "org",
		enabled = false,
		config = function()
			require("orgmode").setup_ts_grammar()
			require("orgmode").setup({
				org_agenda_files = { "~/MEGAsync/org/*" },
				org_default_notes_file = "~/Megasync/org/refile.org",
			})
		end,
	},
	{
		"akinsho/org-bullets.nvim",
		lazy = true,
		ft = "org",
		enabled = false,
		config = true,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		--ft = "markdown",
		--Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		event = {
			-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
			-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
			"BufReadPre "
				.. vim.fn.expand("~")
				.. "/Nextcloud/Noumiso/**.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/Nextcloud/Noumiso/**.md",
		},
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
			-- see below for full list of optional dependencies 👇
		},
		opts = {
			workspaces = {
				{
					name = "Noumiso",
					path = "~/Nextcloud/Noumiso",
				},
			},
      templates = {
        subdir = "_templates"
      }
			-- see below for full list of options 👇
		},
	},
}
