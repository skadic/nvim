local M = {}

local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment" })
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = comment_hl.fg, bg = normal_hl.bg })

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec2(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      {
        output = false,
      }
    )
  end
end

local MiniIcons = require("mini.icons")

local function lsp_keymaps(bufnr)
  local wk = require("which-key")
  local opts = { noremap = true, silent = true }

  wk.add({
    { "gd", "<cmd>Telescope lsp_definitions<CR>", desc = "Definition" },
    { "gi", "<cmd>Telescope lsp_implementations<CR>", desc = "Implementation" },
    { "gr", "<cmd>Telescope lsp_references<CR>", desc = "References" },
    { "gs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document Symbols" },
    { "gS", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Workspace Symbols" },
  }, opts)

  wk.add({
    { "<leader>l", group = "Language Server", icon = MiniIcons.get("default", "lsp") },
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
    { "<leader>t", group = "Tests", icon = "󰙨" },
    { "<leader>tr", "<cmd>Neotest run<cr>", desc = "Run Tests", icon = "󰙨" },
    { "<leader>ts", "<cmd>Neotest stop<cr>", desc = "Stop Tests", icon = "󰙨" },
    { "<leader>to", "<cmd>Neotest output<cr>", desc = "Test Output", icon = "󰙨" },
    { "<leader>tO", "<cmd>Neotest output-panel<cr>", desc = "Test Output Panel", icon = "󰙨" },
    { "T", "<cmd>Neotest summary<cr>", desc = "Toggle Test Summary", icon = "󰙨" },
    { "]t", "<cmd>Neotest jump next<cr>", desc = "Next Test", icon = "󰙨" },
    { "[t", "<cmd>Neotest jump prev<cr>", desc = "Previous Test", icon = "󰙨" },
  }, opts)

  -- Setup the goto commands for diagnostics

  wk.add({
    {
      "[d",
      function()
        vim.diagnostic.jump({ count = -1, float = true })
      end,
      desc = "Previous Diagnostic",
    },
    {
      "]d",
      function()
        vim.diagnostic.jump({ count = 1, float = true })
      end,
      desc = "Next Diagnostic",
    },
  })
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
  --require("lsp_signature").on_attach({}, bufnr)

  if not client == "jdtls" then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

--[[
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return M
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
]]

local status_ok, blink = pcall(require, "blink.cmp")
if not status_ok then
  return M
end

M.capabilities = blink.get_lsp_capabilities(capabilities)

return M
