return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see above for full list of optional dependencies ☝️
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "/Users/tariq/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault/personal",
      },
      {
        name = "work",
        path = "/Users/tariq/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault/work",
      },
    },
    notes_subdir = "inbox",              -- subdirectory for notes, relative to the vault path
    new_notes_location = "notes_subdir", -- where to create new notes, can be "notes" or "inbox"
    note_id = "title,date",              -- how to generate note IDs, can be "title", "date", or "title,date"
    disable_frontmatter = true,
    templates = {
      folder = "/Users/tariq/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault/templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    completion = {
      nvim_cmp = true, -- if using nvim-cmp, set to true to enable completion
      min_chars = 2,   -- minimum number of characters to trigger completion
    },
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      }
    },
  },
}
