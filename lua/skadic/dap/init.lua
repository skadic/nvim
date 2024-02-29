local status_ok, dap = pcall(require, "dap")

if not status_ok then
	return
end

require("dapui").setup()

dap.configurations.cpp = {
	{
		type = "rt_lldb",
		request = "launch",
		name = "Launch Debug Session",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
	},
}
dap.configurations.rust = {
	{
		type = "rt_lldb",
		request = "launch",
		name = "Launch Debug Session",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
	},
}
