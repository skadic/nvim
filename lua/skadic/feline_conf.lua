local ctpn_status_ok, catppuccin = pcall(require, "catppuccin.palettes")
if not ctpn_status_ok then
	return
end
local palette = catppuccin.get_palette("mocha")

local theme = {
	fg = palette.text,
	bg = palette.mantle,
	black = palette.crust,
	skyblue = palette.sky,
	cyan = palette.teal,
	green = palette.green,
	oceanblue = palette.sapphire,
	magenta = palette.pink,
	orange = palette.peach,
	red = palette.red,
	violet = palette.mauve,
	white = palette.text,
	yellow = palette.yellow,
}

local vi_mode_colors = {
	NORMAL = theme.green,
	INSERT = theme.red,
	VISUAL = theme.magenta,
	OP = theme.green,
	BLOCK = theme.blue,
	REPLACE = theme.violet,
	["V-REPLACE"] = theme.violet,
	ENTER = theme.cyan,
	MORE = theme.cyan,
	SELECT = theme.orange,
	COMMAND = theme.orange,
	SHELL = theme.green,
	TERM = theme.green,
	NONE = theme.yellow,
}

local function lsp_name()
	local clients = vim.lsp.get_clients()
	if clients == nil or next(clients) == nil or clients[1] == nil then
		return ""
	end

	for _, client in ipairs(clients) do
		if not (client.name == "null-ls") then
			return " " .. client.name
		end
	end

	local client = clients[1].name
	return " " .. client
end

local function ft_icon()
	local ft = vim.bo.filetype
	local icon = require("nvim-web-devicons").get_icon_by_filetype(ft)
	if icon == nil then
		if ft == "alpha" then
			return ""
		else
			return ""
		end
	end
	return icon
end

local function table_to_string(tbl)
	local result = "{"
	for k, v in pairs(tbl) do
		-- Check the key type (ignore any numerical keys - assume its an array)
		if type(k) == "string" then
			result = result .. '["' .. k .. '"]' .. "="
		end

		-- Check the value type
		if type(v) == "table" then
			result = result .. table_to_string(v)
		elseif type(v) == "boolean" then
			result = result .. tostring(v)
		else
			result = result .. '"' .. v .. '"'
		end
		result = result .. ","
	end
	-- Remove leading commas from the result
	if result ~= "" then
		result = result:sub(1, result:len() - 1)
	end
	return result .. "}"
end

local function trim(s)
	local from = s:match("^%s*()")
	return from > #s and "" or s:match(".*%S", from)
end

local function git_branch()
	local status_result = vim.system({ "git", "status" }):wait()
	if status_result.code ~= 0 then
		return ""
	end
	local branch_result = vim.system({ "git", "branch" }, { text = true }):wait().stdout
	local grep_result = vim.system({ "grep", "\\*", "-" }, { stdin = branch_result, text = true }):wait().stdout
	if grep_result == nil then
		return "git uwu"
	end
	local result = trim(grep_result:gsub("*", ""))
	return result
end

local navic = require("nvim-navic")

local comps = {
	mode = {
		provider = {
			name = "vi_mode",
			opts = {
				show_mode_name = true,
				padding = "center",
			},
		},
		icon = "",
		hl = function()
			return {
				name = require("feline.providers.vi_mode").get_mode_highlight_name(),
				fg = theme.bg,
				bg = require("feline.providers.vi_mode").get_mode_color(),
				style = "bold",
			}
		end,
		right_sep = "slant_right",
		--left_sep = " ",
	},
	file = {
		provider = {
			name = "file_info",
			opts = {
				type = "unique",
				file_modified_icon = "",
			},
		},
		left_sep = "block",
		right_sep = "block",
		hl = {
			fg = theme.sky,
		},
	},
	ft = {
		provider = {
			name = "file_type",
			opts = {
				--filetype_icon = false,
				--case = "lowercase",
			},
		},
		hl = {
			fg = theme.bg,
			bg = theme.sky,
		},
		left_sep = "left_slant",
		right_sep = "right_slant",
	},
	position = {
		provider = {
			name = "position",
		},
	},
	breadcrumbs = {
		provider = function()
			return navic.get_location()
		end,
		enabled = function()
			return navic.is_available()
		end,
		left_sep = "",
	},
	line_percent = {
		provider = {
			name = "line_percentage",
		},
		hl = {
			fg = theme.red,
		},
		left_sep = "block",
		right_sep = "block",
	},
	scroll = {
		provider = "scroll_bar",
		hl = {
			fg = theme.red,
			bg = theme.red,
		},
	},
	git = {
		branch = {
			provider = function()
				return git_branch()
			end,
			left_sep = "block",
			hl = {
				fg = theme.yellow,
			},
		},
		diff = {
			add = {
				provider = "git_diff_added",
				hl = {
					fg = theme.green,
				},
			},
			remove = {
				provider = "git_diff_removed",
				hl = {
					fg = theme.red,
				},
			},
			change = {
				provider = "git_diff_changed",
				hl = {
					fg = theme.oceanblue,
				},
			},
		},
	},
	lsp = {
		provider = lsp_name,
		hl = {
			fg = theme.orange,
			style = "bold",
		},
		icon = ft_icon,
		left_sep = "block",
	},
	diag = {
		error = {
			provider = "diagnostic_errors",
			hl = {
				fg = theme.red,
			},
		},
		warn = {
			provider = "diagnostic_warnings",
			hl = {
				fg = theme.yellow,
			},
		},
		info = {
			provider = "diagnostic_info",
			hl = {
				fg = theme.cyan,
			},
		},
	},
}

return {
	bar = {
		components = {
			active = {
				{
					comps.mode,
					comps.file,
					comps.position,
					comps.diag.error,
					comps.diag.warn,
					comps.diag.info,
				},
				{
					comps.ft,
					comps.git.diff.add,
					comps.git.diff.change,
					comps.git.diff.remove,
					comps.git.branch,
					comps.lsp,
					comps.line_percent,
					comps.scroll,
				},
			},
			inactive = {
				comps.file,
				comps.diag.error,
				comps.diag.warn,
				comps.diag.info,
			},
		},
		conditional_components = {},
		custom_providers = {},
		theme = theme,
		vi_mode_colors = vi_mode_colors,
		bg = theme.bg,
	},
	winbar = {
		components = {
			active = {
				{
					comps.file,
					comps.breadcrumbs,
				},
				{},
			},
			inactive = {
				{
					comps.file,
				},
			},
		},
	},
}
