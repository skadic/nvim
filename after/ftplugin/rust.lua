local wk = require("which-key")
local wk_opts = { mode = "n", prefix="<leader>l", noremap = true, silent = true }

wk.register({
  x = { function() require("ferris.methods.expand_macro")() end, "Expand macro" },
  m = { function() require("ferris.methods.view_memory_layout")() end, "View memory layout" },
  o = { function() require("ferris.methods.open_cargo_toml")() end, "Open Cargo.toml" },
  E = { function() require("ferris.methods.open_documentation")() end, "Open Documentation" },
}, wk_opts)
