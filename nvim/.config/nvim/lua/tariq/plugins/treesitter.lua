return {
  "nvim-treesitter/nvim-treesitter",
  commit = "310f0925",
  build = ":TSUpdate",
  event = "bufreadpost",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,

      ensure_installed = {
        "markdown",
        "markdown_inline",
      },

      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          -- init_selection = "<cr>",
          -- node_incremental = "<cr>",
          -- scope_incremental = "<s-cr>",
          -- node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ap"] = "@parameter.outer",
            ["ip"] = "@parameter.inner",
            -- ["as"] = "@scope",

          },
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "v",  -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
        },
      },
    })

    -- Fix for Neovim 0.12+ API change: iter_matches now returns captures as
    -- table<integer, TSNode[]> instead of table<integer, TSNode>.
    -- nvim-treesitter's query_predicates.lua hasn't been updated for this.
    if vim.fn.has("nvim-0.12") == 1 then
      local query = require("vim.treesitter.query")

      local function get_node(match, id)
        local val = match[id]
        if not val then return nil end
        if type(val) == 'userdata' then return val end
        return val[1]
      end

      local non_filetype_match_injection_language_aliases = {
        ex = "elixir",
        pl = "perl",
        sh = "bash",
        uxn = "uxntal",
        ts = "typescript",
      }

      local function get_parser_from_markdown_info_string(injection_alias)
        local match = vim.filetype.match { filename = "a." .. injection_alias }
        return match or non_filetype_match_injection_language_aliases[injection_alias] or injection_alias
      end

      local html_script_type_languages = {
        ["importmap"] = "json",
        ["module"] = "javascript",
        ["application/ecmascript"] = "javascript",
        ["text/ecmascript"] = "javascript",
      }

      local function override_directive(name, handler)
        query.add_directive(name, handler, { force = true })
      end

      override_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
        local node = get_node(match, pred[2])
        if not node then return end
        local type_attr_value = vim.treesitter.get_node_text(node, bufnr)
        local configured = html_script_type_languages[type_attr_value]
        if configured then
          metadata["injection.language"] = configured
        else
          local parts = vim.split(type_attr_value, "/", {})
          metadata["injection.language"] = parts[#parts]
        end
      end)

      override_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
        local node = get_node(match, pred[2])
        if not node then return end
        local injection_alias = vim.treesitter.get_node_text(node, bufnr):lower()
        metadata["injection.language"] = get_parser_from_markdown_info_string(injection_alias)
      end)

      override_directive("downcase!", function(match, _, bufnr, pred, metadata)
        local id = pred[2]
        local node = get_node(match, id)
        if not node then return end
        local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
        if not metadata[id] then metadata[id] = {} end
        metadata[id].text = string.lower(text)
      end)
    end
  end,
}
