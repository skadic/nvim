-- Visual Funsies
return {
  {
    -- Actually color colorcodes #ff0000
    "norcalli/nvim-colorizer.lua",
    name = "colorizer",
    config = function()
      require("colorizer").setup({
        "*",
        html = {
          names = true,
          css = true,
        },
        css = {
          names = true,
          css = true,
        },
      }, {
        names = false,
        mode = "foreground",
      })
    end,
    lazy = true,
    event = { "BufRead" },
  },
  {
    -- Better-looking notification
    "rcarriga/nvim-notify",
    name = "notify",
    config = function()
      require("skadic.notify")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = {
        enabled = true,
      }
    },
  },
  {
    "xiyaowong/transparent.nvim",
    config = function()
      vim.cmd("TransparentEnable")

      require("transparent").setup({ -- Optional, you don't have to run setup.
        extra_groups = {},
        exclude_groups = {},      -- table: groups you don't want to clear
      })
    end,
  },
  { "echasnovski/mini.starter",  version = false, opts = {} },
  { "echasnovski/mini.sessions", version = false, opts = {} },
}
