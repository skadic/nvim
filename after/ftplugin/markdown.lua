vim.g.vim_markdown_folding_disabled = 1

local wk = require("which-key")

--[[wk.add({
  {"<leader>lK", desc = "", remap = false }
})]]
wk.register({
  ["<leader>lK"] = { vim.cmd('execute "normal gg/#<cr>VG"') }
},{noremap = true, silent = true})
