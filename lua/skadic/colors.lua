local M = {
	hl = {},
}

function M.bg_as_hex(group)
	local col = vim.api.nvim_get_hl_by_name(group, true).background
	if col == nil then
		return nil
	end
	return string.format("#%x", col)
end

function M.fg_as_hex(group)
	local col = vim.api.nvim_get_hl_by_name(group, true).foreground
	if col == nil then
		return nil
	end
	return string.format("#%x", col)
end

local function add(name, group)
	local status_ok, col = pcall(vim.api.nvim_get_hl_by_name, group, true)
	if not status_ok then
		vim.notify("highlight group " .. group .. " is empty")
	end
	M.hl[name] = col
end

add("normal", "Normal")
add("error", "DiagnosticError")
add("warning", "DiagnosticWarn")
add("info", "DiagnosticInfo")
add("hint", "DiagnosticHint")

local ctpn_status_ok, catppuccin = pcall(require, "catppuccin.palettes")
if not ctpn_status_ok then
	return
end
local palette = catppuccin.get_palette("mocha")

M.palette = {
	fg = palette.text,
  light_bg = palette.base,
	bg = palette.mantle,
	black = palette.crust,
	skyblue = palette.sky,
	cyan = palette.teal,
	green = palette.green,
	blue = palette.sapphire,
	magenta = palette.pink,
	orange = palette.peach,
	red = palette.red,
	violet = palette.mauve,
	white = palette.text,
	yellow = palette.yellow,
}

return M
