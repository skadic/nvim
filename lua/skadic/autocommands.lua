local create = vim.api.nvim_create_autocmd
local create_group = vim.api.nvim_create_augroup
local delete_group = vim.api.nvim_del_augroup_by_name

create("TextYankPost", {
  desc = "Highlight yanked text",
  group = create_group("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

create({ "BufReadPre", "BufNewFile" }, {
  desc = "Set conceallevel to 2 if editing obsidian vault",
  group = create_group("obsidian-conceallevel", { clear = true }),
  pattern = vim.fn.expand("~") .. "/Nextcloud/Noumiso/**.md",
  callback = function()
    vim.opt.conceallevel = 2
  end,
})

-- Follow the currently opened obisidan note
local obsidian_follow_enabled = false
local obsidian_current_note = ""
local function toggle_obsidian_follow()
  if obsidian_follow_enabled then
    delete_group("obsidian-follow")
    vim.notify("Stopped following note")
    obsidian_follow_enabled = false
  else
    create("BufEnter", {
      desc = "Automatically open the currently open file in obsidian",
      group = create_group("obsidian-follow", { clear = true }),
      pattern = vim.fn.expand("~") .. "/Nextcloud/Noumiso/**.md",
      callback = function()
        local file_name = vim.fn.expand("%")
        if obsidian_current_note ~= file_name then
          vim.cmd("ObsidianOpen " .. file_name)
          obsidian_current_note = file_name
        end
      end,
    })
    vim.notify("Following note")
    obsidian_follow_enabled = true
  end
end

create({ "BufReadPre", "BufNewFile" }, {
  desc = "Set conceallevel to 2 if editing obsidian vault",
  group = create_group("obsidian-keybinds", { clear = false }),
  pattern = vim.fn.expand("~") .. "/Nextcloud/Noumiso/**.md",
  callback = function()
    local wk = require("which-key")
    wk.register({
      name = "Obsidian",
      o = { "<cmd>ObsidianOpen<cr>", "Open Note in Obsidian" },
      n = { "<cmd>ObsidianNew<cr>", "Create new Note" },
      s = { "<cmd>ObsidianSearch<cr>", "Search Vault" },
      r = { "<cmd>ObsidianRename<cr>", "Rename Note" },
      f = { toggle_obsidian_follow, "Follow current Note in Obsidian" },
      l = { "<cmd>ObsidianLinks<cr>", "Show Links from this Note" },
      b = { "<cmd>ObsidianBacklinks<cr>", "Show Backlinks to this Note" },
    }, { prefix = "<leader>o", noremap = true, silent = true })

    -- We override the find-files command
    wk.register({
      ["<leader>ff"] = { "<cmd>ObsidianQuickSwitch<cr>", "Find Note" },
    }, { noremap = true, silent = true })
  end,
})
