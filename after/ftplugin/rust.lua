local wk = require("which-key")
local wk_opts = { mode = "n", prefix = "<leader>l", noremap = true, silent = true }

require("basic.lsp.settings.rust_analyzer")

require("mini.icons")

wk.add({
  icon = MiniIcons.get("filetype", "rust"),
  {
    "<leader>lx",
    function()
      require("ferris.methods.expand_macro")()
    end,
    desc = "Expand macro",
  },
  {
    "<leader>lm",
    function()
      require("ferris.methods.view_memory_layout")()
    end,
    desc = "View memory layout",
  },
  {
    "<leader>lo",
    function()
      require("ferris.methods.open_cargo_toml")()
    end,
    desc = "Open Cargo.toml",
  },
  {
    "<leader>lE",
    function()
      require("ferris.methods.open_documentation")()
    end,
    desc = "Open Documentation",
  },
}, wk_opts)
