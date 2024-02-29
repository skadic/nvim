
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end
local diagnostics = null_ls.builtins.diagnostics

local wk = require("which-key")
local wk_opts = { mode = "n", prefix="<leader>l", noremap = true, silent = true }

wk.register({
  v = { "<cmd>ClangdSwitchSourceHeader<cr>", "Toggle between source file and header" }
}, wk_opts)

null_ls.register(diagnostics.cppcheck.with({
  extra_args = function (params)
    if params.filetype == "cpp" then
      return { "--language=c++ --std=c++20" }
    else
      return { "--language=c --std=c11" }
    end
  end
}))
