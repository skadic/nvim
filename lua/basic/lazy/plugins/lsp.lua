return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_, opts)
			return require("basic.lsp.mason-lspconfig")
		end,
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
		},
	},
	{
		"aznhe21/actions-preview.nvim",
		lazy = true,
	},
	{
		"nvim-neotest/neotest",
		lazy = true,
		event = "LspAttach",
		ft = { "java", "rust" },
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function(_, opts)
			local wk = require("which-key")
			local wk_opts = { mode = "n", noremap = true, silent = true }

			opts.adapters = opts.adapters or {}
			vim.list_extend(opts.adapters, {
				["neotest-java"] = {},
				require("rustaceanvim.neotest"),
			})

			require("neotest").setup(opts)

			wk.add({

				{ "<leader>t", group = "Tests", icon = "󰙨" },
				{ "<leader>tr", "<cmd>Neotest run<cr>", desc = "Run Tests", icon = "󰙨" },
				{ "<leader>ts", "<cmd>Neotest stop<cr>", desc = "Stop Tests", icon = "󰙨" },
				{ "<leader>to", "<cmd>Neotest output<cr>", desc = "Test Output", icon = "󰙨" },
				{ "<leader>tO", "<cmd>Neotest output-panel<cr>", desc = "Test Output Panel", icon = "󰙨" },
				{ "T", "<cmd>Neotest summary<cr>", desc = "Toggle Test Summary", icon = "󰙨" },
				{ "]t", "<cmd>Neotest jump next<cr>", desc = "Next Test", icon = "󰙨" },
				{ "[t", "<cmd>Neotest jump prev<cr>", desc = "Previous Test", icon = "󰙨" },
			}, wk_opts)
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
}
