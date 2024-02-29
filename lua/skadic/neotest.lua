local neotest = require("neotest")

local wk = require("which-key")
local wk_opts = { mode = "n", prefix="<leader>t", noremap = true, silent = true }

wk.register({
  name = "Test",
  r = { function() neotest.run.run() end, "Run nearest test" },
  R = { function() neotest.run.run(vim.fn.expand("%")) end, "Run tests in file" },
  s = { function() neotest.run.stop() end, "Stop nearest test" },

}, wk_opts)

neotest.setup({
	adapters = {
		require("neotest-gtest"),
    require("rustaceanvim.neotest")
	},
})
