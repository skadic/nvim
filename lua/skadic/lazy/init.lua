-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

-- Install your plugins here
lazy.setup("skadic.lazy.plugins", {
	install = {
		colorscheme = { "catppuccin" },
	},
	ui = {
		border = "rounded",
	},
  lockfile = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json"
})
