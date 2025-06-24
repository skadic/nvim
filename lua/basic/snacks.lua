local M = {}

---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
local function lsp_progress(ev)
	---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
	local progress = vim.defaulttable()
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
	if not client or type(value) ~= "table" then
		return
	end
	local p = progress[client.id]

	for i = 1, #p + 1 do
		if i == #p + 1 or p[i].token == ev.data.params.token then
			p[i] = {
				token = ev.data.params.token,
				msg = ("[%3d%%] %s%s"):format(
					value.kind == "end" and 100 or value.percentage or 100,
					value.title or "",
					value.message and (" **%s**"):format(value.message) or ""
				),
				done = value.kind == "end",
			}
			break
		end
	end

	local msg = {} ---@type string[]
	progress[client.id] = vim.tbl_filter(function(v)
		return table.insert(msg, v.msg) or not v.done
	end, p)

	local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
	vim.notify(table.concat(msg, "\n"), "info", {
		id = "lsp_progress",
		title = client.name,
		opts = function(notif)
			notif.icon = #progress[client.id] == 0 and " "
				or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
		end,
	})
end

local function dashboard_opts()
	return {
		enabled = true,
		sections = {
			{ section = "header" },
			{
				pane = 2,
				section = "terminal",
				cmd = "colorscript -e square",
				height = 5,
				padding = 1,
			},
			{ section = "keys", gap = 1, padding = 1 },
			{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
			{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
			{
				pane = 2,
				icon = " ",
				title = "Git Status",
				section = "terminal",
				enabled = function()
					return Snacks.git.get_root() ~= nil
				end,
				cmd = "git status --short --branch --renames",
				height = 5,
				padding = 1,
				ttl = 5 * 60,
				indent = 3,
			},
			{ section = "startup" },
		},
	}
end

---@type snacks.Config
local function opts()
	return {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = false },
		dashboard = dashboard_opts(),
		explorer = { enabled = false },
		indent = { enabled = true },
		input = { enabled = false },
		picker = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	}
end

M.on_load = function()
	local snacks = require("snacks")
	snacks.setup(opts())
	vim.api.nvim_create_autocmd("LspProgress", { callback = lsp_progress })
	vim.api.nvim_create_autocmd("User", {
		pattern = "OilActionsPost",
		callback = function(event)
			if event.data.actions.type == "move" then
				Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
			end
		end,
	})
	local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment" })
	vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = comment_hl.fg, bg = nil })
end

return M
