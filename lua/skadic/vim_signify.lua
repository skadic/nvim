vim.g.signify_sign_add = "▎"
vim.g.signify_sign_change = "▎"
vim.g.signify_sign_delete = ""
vim.g.signify_sign_delete_first_line = ""
vim.g.signify_sign_delete_above_and_below = ""
vim.g.signify_sign_change_delete = "▎"

local palette = require("skadic.colors").palette

vim.api.nvim_set_hl(0, "SignifySignAdd", { fg = palette.green, bg = "NONE" })
vim.api.nvim_set_hl(0, "SignifySignChange", { fg = palette.yellow, bg = "NONE" })
vim.api.nvim_set_hl(0, "SignifySignDelete", { fg = palette.red, bg = "NONE" })
