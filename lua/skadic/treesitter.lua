local configs = require("nvim-treesitter.configs")

configs.setup({
	ensure_installed = { "rust", "cpp", "lua", "json", "css", "html", "python", "latex" },
	sync_install = false,
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml" } },
	rainbow = {
		enable = true,
		--extended_mode = true,
		max_file_lines = nil,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = { query = "@function.outer", desc = "Select outer part of function" },
				["if"] = { query = "@function.inner", desc = "Select inner part of function" },
				["ac"] = { query = "@class.outer", desc = "Select outer part of class" },
				["ic"] = { query = "@class.inner", desc = "Select inner part of class" },
				["ao"] = { query = "@block.outer", desc = "Select outer part of block" },
				["io"] = { query = "@block.inner", desc = "Select inner part of block" },
				["ar"] = { query = "@frame.outer", desc = "Select outer part of frame" },
				["ir"] = { query = "@frame.inner", desc = "Select inner part of frame" },
				["aa"] = { query = "@statement.outer", desc = "Select outer part of statement" },
			},
		},
	},
})
