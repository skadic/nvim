local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local wk = require("which-key")

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Remove these bindings so I can use them for something else
keymap("", "<M-j>", "<Nop>", opts)
keymap("", "<M-k>", "<Nop>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

--vim.keymap.set("n", "[d", require("delimited").goto_prev, opts)
--vim.keymap.set("n", "]d", require("delimited").goto_next, opts)

local wk_opts = { mode = "n", prefix = "<leader>", noremap = true, silent = true }

require("mini.icons")
require("snacks")

local function string_empty(str)
  return str == '' or str == nil
end

wk.add({
  {"\\", Snacks.picker.explorer, desc = "File Explorer"},
  {"<leader>e", Snacks.picker.explorer, desc = "File Explorer (Explorer)"},
  {"<leader>E", function () require("oil").toggle_float() end, desc = "File Explorer (Oil)"},
	--{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "File Explorer", icon = "" },
	{ "<leader>L", "<cmd>Lazy<cr>", desc = "Open Lazy", icon = "󰒲" },
	{ "<leader>M", "<cmd>Mason<cr>", desc = "Open Mason", icon = "󰏓" },

	-- Find
	{ "<leader>f", group = "Find" },
	{
		"<leader>fg",
		function()
			-- We want to just call the normal find files command if the current dir is not a git directory
			if string_empty(Snacks.git.get_root(0)) then
				Snacks.picker.files()
      else
				Snacks.picker.git_files()
      end
		end,
		desc = "Git Files",
    icon = MiniIcons.get("filetype", "git")
	},
	{ "<leader>ff", Snacks.picker.files, desc = "Find File", icon = MiniIcons.get("default", "file") },
	{ "<leader>fb", Snacks.picker.buffers, desc = "Search Buffers", icon = MiniIcons.get("default", "file") },
	{ "<leader>fl", Snacks.picker.grep, desc = "Live Grep", icon = MiniIcons.get("filetype", "text") },
	{ "<leader>fh", Snacks.picker.help, desc = "Search Help" },
	{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todos" },

	-- LSP
	{ "<leader>l", group = "Language Server", icon = "" },
	{
		"<leader>lf",
		function()
			require("conform").format()
		end,
		desc = "Format File",
	},

  -- Folds
  { "zR", require("ufo").openAllFolds, desc = "Open all Folds" },
  { "zM", require("ufo").closeAllFolds, desc = "Close all Folds" },
})

-- Insert --
-- Press jk fast to enter normal mode
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts) -- stop nvim from yanking things when pasting over other things

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

return {
  add = wk.add,
	register = function(binds, key_opts)
		wk.register(binds, key_opts or wk_opts)
	end,
	opts = wk_opts,
}
