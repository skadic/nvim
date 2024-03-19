vim.g.vim_markdown_folding_disabled = 1

local wk = require("which-key")

wk.register({
  ["<leader>lK"] = { vim.cmd('execute "normal gg/#<cr>VG"') }
},{noremap = true, silent = true})
