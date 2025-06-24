return {
	{
		"mason-org/mason.nvim",
		opts = require("basic.lsp.mason"),
		lazy = true,
		cmd = "Mason",
    version = "*"
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = require("basic.lsp.mason-lspconfig"),
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
		},
    version = "*"
	},
	{
		"aznhe21/actions-preview.nvim",
		lazy = true,
		event = { "LspAttach" },
	},
	{
		"stevearc/conform.nvim",
    version = "*",
		event = { "BufReadPre", "BufWritePre", "BufNewFile" },
		opts = {
			formatters_by_ft = {
				javascript = { "biome" },
				typescript = { "biome" },
				javascriptreact = { "biome" },
				typescriptreact = { "biome" },
				html = { "htmlbeautifier" },
				css = { "biome" },
				svelte = { "biome" },
				lua = { "stylua" },
				xml = { "xmlformat" },
				json = { "jq" },
				rust = { "rustfmt" },
				toml = { "taplo" },
				sql = { "sqlfluff" },
				yaml = { "yamlfmt" },
				gleam = { "gleam" },
				just = { "just" },
				java = { "google-java-format" },
        zsh = { "beautysh" },
        sh = { "beautysh" },
        bash = { "beautysh" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = { "BufReadPre", "BufWritePre", "BufNewFile" },
		config = function()
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})

			require("lint").linters_by_ft = {
				yaml = { "yamllint" },
				lua = { "selene" },
				json = { "biomejs" },
				svelte = { "biomejs" },
				sql = { "sqlfluff" },
				typescript = { "oxlint", "biomejs" },
				javascript = { "oxlint", "biomejs" },
				html = { "prettierd" },
				css = { "biome" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        zsh = { "shellcheck" },
			}
		end,
	},
	{
		"nvim-neotest/neotest",
    version = "*",
		lazy = true,
		cmd = "Neotest",
		ft = { "java", "rust" },
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function(_, opts)
			opts.adapters = opts.adapters or {}
			vim.list_extend(opts.adapters, {
				["neotest-java"] = {},
				require("rustaceanvim.neotest"),
			})
			require("neotest").setup(opts)
		end,
	},
	{ "ray-x/lsp_signature.nvim", lazy = true, event = "LspAttach", opts = {} },
}
