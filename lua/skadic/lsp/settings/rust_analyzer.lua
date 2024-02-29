--local status_ok_rt, rust_tools = pcall(require, "rust-tools")
--if not status_ok_rt then
--	vim.notify("Rust tools setup failed", "error")
--end

local install_dir = vim.fn.stdpath("data") .. "/mason"

local extension_path = install_dir .. "/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

local rust_on_attach = function(client, bufnr) 
  require("skadic.lsp.handlers").on_attach(client, bufnr)
  --require("lsp-inlayhints").on_attach(client, bufnr)
end

vim.g.rustaceanvim = {
	-- Plugin configuration
	inlay_hints = {
		highlight = "NonText",
	},
	tools = {
		hover_actions = {
			auto_focus = true,
		},
	},
	-- LSP configuration
	server = {
		on_attach = rust_on_attach,
		capabilities = require("skadic.lsp.handlers").capabilities,
		settings = {
			-- rust-analyzer language server configuration
			["rust-analyzer"] = {
				procMacro = {
					enable = true,
				},
				checkOnSave = {
					--command = "clippy",
					command = "check",
				},
			},
		},
	},
	-- DAP configuration
	dap = {},
}

--[[
local opts = {
	server = {
		on_attach = require("skadic.lsp.handlers").on_attach,
		capabilities = require("skadic.lsp.handlers").capabilities,
		settings = {
			["rust-analyzer"] = {
				procMacro = {
					enable = true,
				},
				checkOnSave = {
					--command = "clippy",
					command = "check",
				},
			},
		},
	},
	tools = {
		executor = require("rust-tools/executors").toggleterm,
		on_initialized = function()
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
				pattern = { "*.rs" },
				callback = function()
					vim.lsp.codelens.refresh()
				end,
			})
		end,
	},
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
}

rust_tools.setup(opts)
]]
