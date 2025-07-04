return {
  { "echasnovski/mini.files", version = false, opts = {} },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      --"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "echasnovski/mini.icons",
      "MunifTanjim/nui.nvim",
      --"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      -- Allows you to pick windows
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
          require("window-picker").setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
          })
        end,
      },
    },
    lazy = true,
    cmd = "Neotree",
    event = "BufEnter",
    opts = require("basic.neotree"),
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    },
  },
  --[[ {
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				notification = {
					override_vim_notify = true,
				},
			})
		end,
	}, ]]
  { "echasnovski/mini.statusline", version = "*", opts = {} },
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
}
