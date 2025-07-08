return {
  "hrsh7th/nvim-cmp",
  event = {
    "BufNewFile",
    "BufReadPre",
    "InsertEnter",
  },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
  },
  config = function()
    -- Set up nvim-cmp.
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = "luasnip" }, -- For luasnip users.
        { name = "nvim_lsp" },
        { name = "copilot" },
        { name = "render-markdown" },
        { name = "obsidian" }

      }, {
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
          mode = "symbol_text",
          menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
            -- codeium = "[Codeium]",
          }),
        }),
      },
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      }, {
        { name = "buffer" },
      }),
    })

    -- vim-dadbod
    cmp.setup.filetype("mysql", {
      sources = cmp.config.sources({
        { name = "vim-dadbod-completion" },
      }, {
        { name = "buffer" },
      }),
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    -- Helper for LSP keymaps
    local function setup_lsp_keymaps()
      local set = vim.keymap.set
      set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", {})
      set("n", "K", vim.lsp.buf.hover, {})
      -- set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", {})
      -- set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", {})
      set("n", "<leader>lr", vim.lsp.buf.rename, {})
      set("n", "<leader>la", vim.lsp.buf.code_action, {})
      set("n", "gr", "<cmd>Telescope lsp_references<cr>", {})
      set("n", "<leader>ls", vim.lsp.buf.signature_help, {})
      set("n", "<leader>ld", vim.diagnostic.open_float, {})
      set("n", "<leader>lq", vim.diagnostic.setloclist, {})
      set("n", "<leader>lD", "<cmd>Telescope diagnostics<cr>", {})
      set("n", "[d", vim.diagnostic.goto_prev, {})
      set("n", "]d", vim.diagnostic.goto_next, {})
      set("n", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, {})
    end

    -- Helper for setting up diagnostic signs
    local function setup_diagnostic_signs()
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = "󰋼 ",
            [vim.diagnostic.severity.HINT] = "󰌵 ",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
      })
    end

    -- Setup lspconfig and lsp servers
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local function on_attach(_, _)
      setup_lsp_keymaps()
      setup_diagnostic_signs()
    end

    local servers = {
      "cssls",
      "biome",
      "intelephense",
      "ts_ls",
      "lua_ls",
      "jsonls",
      "emmet_ls",
      "sqlls",
      "pylsp",
      "html",
      "gopls",
    }
    for _, lsp in ipairs(servers) do
      require("lspconfig")[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end
  end,
}
