local M = {}

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

local function lsp_keymaps(bufnr)
	local wk = require("which-key")

	wk.add({
		{ "gd", "<cmd>Telescope lsp_definitions<CR>", desc = "Definition" },
		{ "gi", "<cmd>Telescope lsp_implementations<CR>", desc = "Implementation" },
		{ "gr", "<cmd>Telescope lsp_references<CR>", desc = "References" },
		{ "gs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document Symbols" },
		{ "gS", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Workspace Symbols" },
	})

	wk.add({
		{ "<leader>l", group = "Language Server" },
		{
			"<leader>la",
			function()
				require("actions-preview").code_actions()
			end,
			desc = "Code Action",
		},
		{ "<leader>le", "<Plug>(doge-generate)", desc = "Generate Documentation" },
		{
			"<leader>lf",
			function()
				require("conform").format()
			end,
			desc = "Format File",
		},
		{
			"<leader>lc",
			function()
				vim.lsp.codelens.run()
			end,
			desc = "Run Code Lens",
		},
		{
			"<leader>lh",
			function()
				vim.lsp.buf.hover()
			end,
			desc = "Hover",
		},
		{
			"<leader>lr",
			function()
				vim.lsp.buf.rename()
			end,
			desc = "Rename",
		},
		{
			"<leader>ls",
			function()
				vim.lsp.buf.signature_help()
			end,
			desc = "Signature Help",
		},
	})

	-- Setup the goto commands for diagnostics
	local goto_next, goto_prev
	local delimited_status_ok, delimited = pcall(require, "delimited")
	if delimited_status_ok then
		goto_next = delimited.goto_next
		goto_prev = delimited.goto_prev
	else
		goto_next = vim.diagnostic.goto_next
		goto_prev = vim.diagnostic.goto_prev
	end

	wk.add({
		{ "[d", goto_prev, desc = "Previous Diagnostic" },
		{ "]d", goto_next, desc = "Next Diagnostic" },
	})
end

M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)

	vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return M
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
