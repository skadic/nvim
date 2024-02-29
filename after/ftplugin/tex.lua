local wk = require("which-key")

local wk_opts = { mode = "n", prefix = "<leader>", noremap = true, silent = true }

wk.register({
	t = {
		name = "Tex",
		b = { "<cmd>TexlabBuild<cr>", "Build Latex Project" },
	},
}, wk_opts)
