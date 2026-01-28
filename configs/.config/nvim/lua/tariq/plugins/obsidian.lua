return {
  "epwalsh/obsidian.nvim",
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

    -- see below for full list of optional dependencies 👇
  },
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
    notes_subdir = "inbox", -- subdirectory for notes, relative to the vault path
    new_notes_location = "notes_subdir", -- where to create new notes, can be "notes" or "inbox"
    disable_frontmatter = false,
    -- Optional, customize how note file names are generated given the ID, target directory, and title.
    note_path_func = function(spec)
      -- This is equivalent to the default behavior.
      local path = spec.dir / tostring(spec.title)
      return path:with_suffix(".md")
    end,
    -- Optional, alternatively you can customize the frontmatter data.
    ---@return table
    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      local date = note.metadata and note.metadata.date or os.date("%Y-%m-%d")
      local url = "\n   -"
      local tags = "\n  -"
      local out = {
        date = date, -- date of the note, defaults to current date
        tags = tags,
        url = url,
      }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,
    templates = {
      folder = "/Users/tariq/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault/templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    completion = {
      nvim_cmp = true, -- if using nvim-cmp, set to true to enable completion
      min_chars = 2, -- minimum number of characters to trigger completion
    },

    -- see below for full list of options 👇
  },
}
