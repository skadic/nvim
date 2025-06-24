local colorscheme = "catppuccin-mocha"

local handle = io.popen("uname -n")
local device_name
if handle == nil then
  vim.notify("could not get device name", vim.log.levels.ERROR)
  device_name = handle:read("*a")
  handle:close()
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
end
