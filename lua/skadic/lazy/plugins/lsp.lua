-- LSP and Coding-Related stuff
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"SmiteshP/nvim-navbuddy",
		},
	},
	-- Mason
	{
		-- Allow installing tools like LSP Servers, Linters etc
		"williamboman/mason.nvim",
		lazy = true,
		cmd = "Mason",
		event = { "BufRead" },
		opts = require("skadic.lsp.mason"),
	},
	{
		"onsails/lspkind.nvim",
		config = function()
			--  
			require("lspkind").init({
				symbol_map = {
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",
					Field = "󰜢",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎠",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "󰈇",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "",
					Copilot = "",
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = "BufRead",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
				just = { "just" },
				markdown = { "mdslw" },
				typescript = { { "prettierd", "prettier" } },
				javascript = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				svelte = { { "prettierd", "prettier" } },
				java = { "google-java-format" },
				fennel = { "fnlfmt" },
				gleam = { "gleam" },
				cmake = { "cmake_format" },
				cpp = { "clang_format" },
			},
			formatters = {
				mdslw = {
					prepend_args = { "-w", "0" },
				},
			},
		},
	},
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
			require("statuscol").setup({
				-- configuration goes here, for example:
				-- relculright = true,
				segments = {
					{ text = { "%s" }, click = "v:lua.ScSa" },
					{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
					{
						text = { " ", builtin.foldfunc, " " },
						condition = { builtin.not_empty, true, builtin.not_empty },
						click = "v:lua.ScFa",
					},
				},
			})
		end,
	},
	{ -- Linters
		"mfussenegger/nvim-lint",
		lazy = true,
		event = "BufRead",
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				javascript = { "oxlint", "eslint_d" },
				typescript = { "oxlint", "eslint_d" },
				svelte = { "oxlint", "eslint_d" },
				cpp = { "cpplint" },
				lua = { "selene" },
				proto = { "protolint" },
				cmake = { "cmakelint" },
			}
			lint.linters.protolint = {
				cmd = vim.fn.stdpath("data") .. "/mason/packages/protolint/protolint",
				stdin = true, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
				append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
				args = {}, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
				stream = "stdout", -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
				ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
				env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
				--parser = your_parse_function,
			}
			lint.linters.oxlint = {
				cmd = "oxlint",
				stdin = true, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
				append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
				args = {}, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
				stream = "stdout", -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
				ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
				env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
				--parser = your_parse_function,
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	{
		-- Lsp Configuration for mason
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("skadic.lsp.mason-lspconfig")
		end,
		dependencies = {
			"neovim/nvim-lspconfig", -- Some LSP configs
			"williamboman/mason.nvim",
		},
		lazy = true,
		event = "BufRead",
	},

	{
		-- Debugging
		"mfussenegger/nvim-dap",
		lazy = true,
		enabled = false,
		event = "LspAttach",
		config = function()
			require("skadic.dap.init")
		end,
	},
	{
		-- Generate LSP highlight groups for color schemes without lsp support
		"folke/lsp-colors.nvim",
		lazy = true,
		event = "LspAttach",
	},
	{
		-- Help with function signatures
		"ray-x/lsp_signature.nvim",
		name = "lsp_signature",
		opts = {
			bind = true,
			handler_opts = {
				border = "rounded",
			},
		},
		lazy = true,
		event = "LspAttach",
	},
	{
		-- Documentation Generation
		"kkoomen/vim-doge",
		build = function()
			vim.cmd("call doge#install()")
		end,
		config = function()
			vim.g.doge_doc_standard_cpp = "doxygen_cpp_comment_slash"
			vim.g.doge_doc_standard_c = "doxygen_cpp_comment_slash"
		end,
		lazy = false,
		cmd = "DogeGenerate",
	},

	-- Language-Specific
	{
		-- More capabilities for writing Rust
		"mrcjkb/rustaceanvim",
		lazy = true,
		ft = "rust",
	},
	{
		"vxpm/ferris.nvim",
		lazy = true,
	},
	{
		-- More capabilities for writing C++
		"p00f/clangd_extensions.nvim",
		lazy = true,
		ft = { "cpp", "hpp", "c", "h", "cc", "cxx" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"alepez/vim-gtest",
			"SmiteshP/nvim-navic",
		},
		opts = require("skadic.lsp.settings.clangd"),
	},
	{ "elkowar/yuck.vim", lazy = true, ft = "yuck" },
	{
		"kaarmu/typst.vim",
		ft = "typst",
		lazy = true,
	},
	{
		-- Better Markdown features
		"preservim/vim-markdown",
		dependencies = { "godlygeek/tabular" },
		lazy = true,
		ft = "markdown",
	},
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			local palette = require("skadic.colors").palette
			palette.normal_bg = palette.bg
			palette.title_bg = palette.light_bg
			require("lspsaga").setup({
				ui = {
					theme = "round",
					border = "rounded",
					colors = palette,
				},
			})
		end,
		lazy = true,
		cmd = "Lspsaga",
		event = "LspAttach",
	},
	{ "folke/neodev.nvim", opts = {}, lazy = true, ft = "lua" }, -- for neovim config development
	{
		"nvim-neotest/neotest",
		dependencies = {
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"alfaix/neotest-gtest",
			"mrcjkb/rustaceanvim",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("skadic.neotest")
		end,
		lazy = true,
		ft = { "rust", "cpp", "c" },
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter", -- Better syntax highlighting
		build = ":TSUpdate",
		lazy = true,
		event = "BufRead",
		config = function()
			require("skadic.treesitter")
		end,
		dependencies = {
			{
				"p00f/nvim-ts-rainbow",
				config = function()
					require("nvim-treesitter.configs").setup({
						rainbow = {
							colors = { "#a6e3a1", "#89dceb", "#fab387", "#cba6f7" },
						},
					})
				end,
			},
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
	{ "jbyuki/nabla.nvim", lazy = true, ft = "markdown" },
}
