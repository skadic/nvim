local M = {}

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- enable virtual text
		virtual_text = true,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

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
	local wk_opts = { mode = "n", prefix = "g", noremap = true, silent = true, buffer = bufnr }
	local wk = require("which-key")

	wk.register({
		d = { "<cmd>Telescope lsp_definitions<CR>", "Definition" },
		D = { "<cmd>Lspsaga finder<CR>", "LSP finder" },
		i = { "<cmd>Telescope lsp_implementations<CR>", "Implementation" },
		r = { "<cmd>Telescope lsp_references<CR>", "References" },
		s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
		S = { "<cmd>Telescope lsp_workspace_symbols<CR>", "Workspace Symbols" },
	}, wk_opts)

	wk_opts.prefix = "<leader>l"
	wk.register({
		name = "Language Server",
		a = { "<cmd>lua require('actions-preview').code_actions()<CR>", "Code Action" },
		d = { "<cmd>Lspsaga show_cursor_diagnostics<cr>", "Show Cursor Diagnostic" },
		e = { "<Plug>(doge-generate)", "Generate Documentation" },
		f = {
			function()
				--vim.lsp.buf.format()
				require("conform").format()
			end,
			"Format File",
		},
		c = {
			function()
				vim.lsp.codelens.run()
			end,
			"Run Code Lens",
		},
		h = {
			function()
				vim.lsp.buf.hover()
			end,
			"Hover",
		},
		r = { "<cmd>Lspsaga rename<cr>", "Rename" },
		s = {
			function()
				vim.lsp.buf.signature_help()
			end,
			"Signature Help",
		},
	}, wk_opts)

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

	wk_opts.prefix = ""
	wk.register({
		["[d"] = { goto_prev, "Previous Diagnostic" },
		["]d"] = { goto_next, "Next Diagnostic" },
	}, wk_opts)

	local status_ok, dapui = pcall(require, "dapui")

	if status_ok then
		wk.register({
			["<leader>d"] = {
				function()
					dapui.toggle()
				end,
				"Toggle Debug UI",
			},
		}, wk_opts)
	end
end

local disable_format = { tsserver = 1, clangd = 1, sumneko_lua = 1, rust_analyzer = 1 }

M.on_attach = function(client, bufnr)
	if disable_format[client.name] == 1 then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
	require("nvim-navic").attach(client, bufnr)

	vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
