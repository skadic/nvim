local colors = require("skadic.colors")
local ctpn_status_ok, catppuccin = pcall(require, "catppuccin.palettes")
if not ctpn_status_ok then
	return
end
local palette = catppuccin.get_palette("mocha")


local theme = colors.palette
theme.oceanblue = palette.sapphire
theme.skyblue = palette.sky

-- LuaFormatter off
vim.api.nvim_set_hl(0, "NavicIconsFile",          {default = true, bg = theme.bg, fg = theme.red})
vim.api.nvim_set_hl(0, "NavicIconsModule",        {default = true, bg = theme.bg, fg = theme.orange})
vim.api.nvim_set_hl(0, "NavicIconsNamespace",     {default = true, bg = theme.bg, fg = theme.orange})
vim.api.nvim_set_hl(0, "NavicIconsPackage",       {default = true, bg = theme.bg, fg = theme.orange})
vim.api.nvim_set_hl(0, "NavicIconsClass",         {default = true, bg = theme.bg, fg = theme.oceanblue})
vim.api.nvim_set_hl(0, "NavicIconsStruct",        {default = true, bg = theme.bg, fg = theme.oceanblue})
vim.api.nvim_set_hl(0, "NavicIconsEnum",          {default = true, bg = theme.bg, fg = theme.green})
vim.api.nvim_set_hl(0, "NavicIconsInterface",     {default = true, bg = theme.bg, fg = theme.violet})
vim.api.nvim_set_hl(0, "NavicIconsProperty",      {default = true, bg = theme.bg, fg = theme.cyan})
vim.api.nvim_set_hl(0, "NavicIconsField",         {default = true, bg = theme.bg, fg = theme.cyan})
vim.api.nvim_set_hl(0, "NavicIconsConstructor",   {default = true, bg = theme.bg, fg = theme.skyblue})
vim.api.nvim_set_hl(0, "NavicIconsMethod",        {default = true, bg = theme.bg, fg = theme.skyblue})
vim.api.nvim_set_hl(0, "NavicIconsFunction",      {default = true, bg = theme.bg, fg = theme.skyblue})
vim.api.nvim_set_hl(0, "NavicIconsVariable",      {default = true, bg = theme.bg, fg = theme.cyan})
vim.api.nvim_set_hl(0, "NavicIconsConstant",      {default = true, bg = theme.bg, fg = theme.cyan})
vim.api.nvim_set_hl(0, "NavicIconsString",        {default = true, bg = theme.bg, fg = theme.green})
vim.api.nvim_set_hl(0, "NavicIconsNumber",        {default = true, bg = theme.bg, fg = theme.magenta})
vim.api.nvim_set_hl(0, "NavicIconsBoolean",       {default = true, bg = theme.bg, fg = theme.magenta})
vim.api.nvim_set_hl(0, "NavicIconsArray",         {default = true, bg = theme.bg, fg = theme.magenta})
vim.api.nvim_set_hl(0, "NavicIconsObject",        {default = true, bg = theme.bg, fg = theme.magenta})
vim.api.nvim_set_hl(0, "NavicIconsKey",           {default = true, bg = theme.bg, fg = theme.magenta})
vim.api.nvim_set_hl(0, "NavicIconsNull",          {default = true, bg = theme.bg, fg = theme.magenta})
vim.api.nvim_set_hl(0, "NavicIconsEnumMember",    {default = true, bg = theme.bg, fg = theme.green})
vim.api.nvim_set_hl(0, "NavicIconsEvent",         {default = true, bg = theme.bg, fg = theme.violet})
vim.api.nvim_set_hl(0, "NavicIconsOperator",      {default = true, bg = theme.bg, fg = theme.fg})
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", {default = true, bg = theme.bg, fg = theme.violet})
vim.api.nvim_set_hl(0, "NavicText",               {default = true, bg = theme.bg, fg = theme.fg})
vim.api.nvim_set_hl(0, "NavicSeparator",          {default = true, bg = theme.bg, fg = theme.red})
-- LuaFormatter on

return {
  highlight = true,
  separator = "  ",
  icons = require("skadic.defs").icons
}
