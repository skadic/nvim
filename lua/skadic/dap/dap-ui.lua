
local status_ok, dapui = pcall(require, "dapui")

if not status_ok then
  return
end

dapui.setup()
local dap = require("dap")

dap.listeners.after.event_initialized["dapui_config"] = function ()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function ()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function ()
  dapui.close()
end

local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

keymap("n", "<F8>", "<cmd>DapStepOver<cr>", default_opts)
keymap("n", "<F7>", "<cmd>DapStepInto<cr>", default_opts)
keymap("n", "<F9>", "<cmd>DapStepOut<cr>", default_opts)
keymap("n", "<F10>", "<cmd>DapContinue<cr>", default_opts)
keymap("n", "<F11>", "<cmd>DapTerminate<cr>", default_opts)


