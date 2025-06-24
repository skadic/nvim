return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    enabled = false,
    dependencies = {
      --{ "3rd/image.nvim", opts = {} },
      { "nvim-neorg/neorg-telescope" },
    },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.highlights"] = {
            config = {
              headings = {
                ["1"] = {
                  prefix = "@markup.heading.1.markdown",
                  title = "@markup.heading.1.markdown",
                },
                ["2"] = {
                  prefix = "@markup.heading.2.markdown",
                  title = "@markup.heading.2.markdown",
                },
                ["3"] = {
                  prefix = "@markup.heading.3.markdown",
                  title = "@markup.heading.3.markdown",
                },
                ["4"] = {
                  prefix = "@markup.heading.4.markdown",
                  title = "@markup.heading.4.markdown",
                },
                ["5"] = {
                  prefix = "@markup.heading.5.markdown",
                  title = "@markup.heading.5.markdown",
                },
                ["6"] = {
                  prefix = "@markup.heading.6.markdown",
                  title = "@markup.heading.6.markdown",
                },
              },
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.export"] = {},
          ["core.export.markdown"] = {
            config = {
              extensions = { "all" },
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/Neorg",
              },
              default_workspace = "notes",
            },
          },
        },
      })
    end,
  },
}
