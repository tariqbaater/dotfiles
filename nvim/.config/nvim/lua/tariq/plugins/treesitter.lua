return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
  },
  config = function()
    require("nvim-treesitter").setup({})

    require("nvim-treesitter").install({
      "markdown",
      "markdown_inline",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "c",
      "cpp",
      "python",
      "javascript",
      "typescript",
      "rust",
      "go",
      "html",
      "css",
      "json",
      "yaml",
      "toml",
      "bash",
      "dockerfile",
      "gitignore",
      "sql",
      "regex",
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })

    local select = require("nvim-treesitter-textobjects.select").select_textobject

    vim.keymap.set({ "x", "o" }, "af", function() select("@function.outer", "textobjects") end, { desc = "outer function" })
    vim.keymap.set({ "x", "o" }, "if", function() select("@function.inner", "textobjects") end, { desc = "inner function" })
    vim.keymap.set({ "x", "o" }, "ac", function() select("@class.outer", "textobjects") end, { desc = "outer class" })
    vim.keymap.set({ "x", "o" }, "ic", function() select("@class.inner", "textobjects") end, { desc = "inner class" })
    vim.keymap.set({ "x", "o" }, "a,", function() select("@parameter.outer", "textobjects") end, { desc = "outer parameter" })
    vim.keymap.set({ "x", "o" }, "i,", function() select("@parameter.inner", "textobjects") end, { desc = "inner parameter" })
  end,
}
