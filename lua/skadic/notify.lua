local status_ok, notify = pcall(require, "notify")

if not status_ok then
	vim.notify("error loading notify")
	return {}
end

vim.notify = notify

notify.setup({
  background_colour = "#000000",
  timeout = 1500,
  fps = 60,
  top_down = false
})
