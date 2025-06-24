vim.call("lexima#add_rule", { char = "<", input_after = ">", filetype = "xml" })
vim.call("lexima#add_rule", { char = "<BS>", at = '<\\%#>', delete = 1, filetype = "xml" })
