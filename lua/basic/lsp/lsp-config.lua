local M = {}

M.setup = function()
  local sign_hl = {
    [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
    [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
    [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
  }

  local config = {
    -- enable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      },
      numhl = sign_hl,
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

return M
