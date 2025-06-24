return {
	{
		"Saghen/blink.cmp",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		version = "*",
		dependencies = {
			"rafamadriz/friendly-snippets", -- a bunch of snippets to use
		},
		config = function(_, opts)
			local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment" })
			vim.api.nvim_set_hl(0, "NonText", { fg = comment_hl.fg, bg = comment_hl.bg })
			require("blink.cmp").setup(opts)
		end,
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			enabled = function()
				return not vim.tbl_contains({}, vim.bo.filetype)
					and vim.bo.buftype ~= "prompt"
					and vim.b.completion ~= false
			end,
			completion = {
				ghost_text = { enabled = true },
				list = {
					selection = "manual", --[[ do not preselect first item when completion window shows ]]
				},
				documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
				menu = {
					auto_show = function(ctx)
						return ctx.mode ~= "cmdline"
					end,
					draw = {
						columns = {
							{ "kind_icon", "label", "label_description", gap = 1 },
							{ "kind" },
						},
						treesitter = { "lsp" },
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								-- Optionally, you may also use the highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return { { -1, 1 + #ctx.icon_gap + 1, group = hl } }
								end,
							},
							kind = {
								ellipsis = false,
								text = function(ctx)
									return ctx.kind
								end,
								-- Optionally, you may also use the highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
			},
			signature = {
				enabled = true,
				window = { border = "rounded" },
			},
			keymap = {
				preset = "none",
				["<CR>"] = { "accept", "fallback" },
				--["<Up>"] = { "select_prev", "fallback" },
				--["<Down>"] = { "select_next", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				cmdline = {
					["<Tab>"] = { "show", "select_next", "fallback" },
					["<S-Tab>"] = { "show", "select_prev", "fallback" },
					--["<Up>"] = { "select_prev", "fallback" },
					--["<Down>"] = { "select_next", "fallback" },
					["<CR>"] = { "accept", "fallback" },
				},
			},
			sources = {
				default = { "lazydev", "lsp", "snippet", "path", "buffer" },
				providers = {
					buffer = {
						name = "Buffer",
						module = "blink.cmp.sources.buffer",
						score_offset = -10,
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					snippet = {
						name = "Snippets",
						module = "blink.cmp.sources.snippets",
					},
					path = {
						name = "Snippet",
						module = "blink.cmp.sources.path",
						score_offset = -5,
					},
				},
			},
		},
	},
	{
		"saghen/blink.compat",
		-- use the latest release, via version = '*', if you also use the latest release for blink.cmp
		version = "*",
		-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
		lazy = true,
		-- make sure to set opts so that lazy.nvim calls blink.compat's setup
		opts = {},
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		enabled = false,
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()
			local check_backspace = function()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
			end

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						luasnip.lsp_expand(args.body) -- For `luasnip` users.
					end,
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
						{ name = "luasnip" }, -- For luasnip users.
					}),
				},
				mapping = {
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
					["<C-e>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					-- Accept currently selected item. If none selected, `select` first item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif check_backspace() then
							fallback()
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
				},
				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						--require("clangd_extensions.cmp_scores"),
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				sources = cmp.config.sources({
					{ name = "lazydev" },
					{ name = "crates" },
					{ name = "neorg" },
					{ name = "nvim_lsp", keyword_length = 3 },
					--{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lua", keyword_length = 3 },
					{ name = "luasnip", keyword_length = 3 },
					{ name = "path" },
				}, {
					{ name = "buffer", keyword_length = 4 },
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						-- Kind icons
						local kind =
							require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"
						return vim_item
					end,
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				window = {
					documentation = cmp.config.window.bordered(),
					completion = {
						--winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = 0,
						side_padding = 0,
					},
				},

				experimental = {
					ghost_text = true,
					native_menu = false,
				},
			})
		end,
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
	},
}
