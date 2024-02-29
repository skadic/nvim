local M = {}

local enabled = false

function M.set(b)
  enabled = b
  vim.diagnostic.config({
    virtual_lines = b,
    virtual_text = not b
  })
end

function M.toggle()
  M.set(not enabled)
end

M.set(enabled)

return M

