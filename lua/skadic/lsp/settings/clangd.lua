local server_opts = {
	on_attach = function(client, bufnr)
		require("skadic.lsp.handlers").on_attach(client, bufnr)

		--require("clangd_extensions.inlay_hints").setup_autocmd()
		--require("clangd_extensions.inlay_hints").set_inlay_hints()
	end,
}
server_opts.capabilities = vim.tbl_deep_extend(
	"force",
	{ require("skadic.lsp.handlers").capabilities },
	{ offsetEncoding = "utf-8" }
)

server_opts.capabilities.offset_encoding = "utf-8"
server_opts.capabilities.offsetEncoding = "utf-8"
return server_opts
