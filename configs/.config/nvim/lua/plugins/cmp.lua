return {
    "hrsh7th/nvim-cmp",
    event = {
        "BufNewFile",
        "BufReadPre",
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
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
                -- { name = "codeium" },
                { name = "nvim_lsp" },
                -- { name = "tailwindcss" }

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
                        codeium = "[Codeium]",
                        -- tailwindcss = "[TailwindCSS]",
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

        -- Set up lspconfig.
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local on_attach = function(_, _)
            vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", {})
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", {})
            vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", {})
            vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, {})
            vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", {})
            vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, {})
            vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, {})
            vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, {})
            vim.keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics<cr>", {})
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
            vim.keymap.set("n", "<leader>lf", function()
                vim.lsp.buf.format({ async = true })
            end, {})
        end

        -- set the diagnostic symbols
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        local servers = {
            "cssls",
            "rust_analyzer",
            "gopls",
            -- php server
            "intelephense",
            "html",
            -- "tsserver",
            "ts_ls",
            "lua_ls",
            "jsonls",
            "clangd",
            "emmet_ls",
            "html",
            "sqlls",
            "pylsp",
            -- "tailwindcss",
        }
        -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
        for _, lsp in ipairs(servers) do
            if lsp == "lua_ls" then
                require("lspconfig")[lsp].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                })
            else
                if lsp == "clangd" then
                    capabilities = vim.lsp.protocol.make_client_capabilities()
                    capabilities.offsetEncoding = { "utf-16" }

                    require("lspconfig")[lsp].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        filetypes = { "c", "cpp", "objc", "objcpp" },
                    })
                else
                    require("lspconfig")[lsp].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end
                if lsp == "sqlls" then
                    require 'lspconfig'.sqlls.setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        filetypes = { 'sql' },
                        root_dir = function(_)
                            return vim.loop.cwd()
                        end,
                    }
                end
                if lsp == "intelephense" then
                    require 'lspconfig'.intelephense.setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        filetypes = { 'php', 'html', 'blade' },
                        root_dir = function(_)
                            return vim.loop.cwd()
                        end,
                    }
                end
                if lsp == "emmet_ls" then
                    require 'lspconfig'.emmet_ls.setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        filetypes = { 'html', 'blade', 'php' },
                        root_dir = function(_)
                            return vim.loop.cwd()
                        end,
                    }
                end
                if lsp == "html" then
                    require 'lspconfig'.html.setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        filetypes = { 'html', 'blade', 'php' },
                        root_dir = function(_)
                            return vim.loop.cwd()
                        end,
                    }
                end
            end
        end
    end,
}
