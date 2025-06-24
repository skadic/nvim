--[[
local status_ok_mason, mason = pcall(require, "mason")
if not status_ok_mason then
	return
end

mason.setup()


local status_ok, mason_lsp = pcall(require, "mason-lspconfig")

if not status_ok then
	return
end
]]

require("basic.lsp.lsp-config").setup()

local opts = {
	handlers = {
		-- default handler for any lsp that doesn't have a specific handler
		function(server_name)
			local server_cfg_status_ok, specific_opts = pcall(require, "basic.lsp.settings." .. server_name)
			local server_opts = {
				on_attach = require("basic.lsp.handlers").on_attach,
				capabilities = require("basic.lsp.handlers").capabilities,
			}
			if server_cfg_status_ok then
				server_opts = vim.tbl_deep_extend("force", server_opts, specific_opts)
			end
			require("lspconfig")[server_name].setup(server_opts)
		end,
		-- targeted overrides for specific language servers
		["rust_analyzer"] = function()
			require("basic.lsp.settings.rust_analyzer")
		end,
		["jdtls"] = function()
			-- Do nothing, we let Lazy handle this
		end,
	},
}

--[[
require("lspconfig").gleam.setup({
	on_attach = require("basic.lsp.handlers").on_attach,
	capabilities = require("basic.lsp.handlers").capabilities,
})
--]]

return opts
