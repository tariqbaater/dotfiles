return {
    -- LSP
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "WhoIsSethDaniel/mason-tool-installer.nvim"
    },
    config = function()
        require("mason").setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })
        require("mason-lspconfig").setup({
            auto_install = true,
            ensure_installed = {
                "clangd",
                "lua_ls",
                "intelephense",
                "rust_analyzer",
                "cssls",
                "gopls",
                "jsonls",
                "emmet_ls",
                "html",
                "pyright",
                "sqlls"
            }
        })

        require("mason-tool-installer").setup({
            ensure_installed = {
                "prettierd",
                "stylua",
                -- "black",
                "isort",
                -- "clang-format",
                "sql-formatter"
            }
        })
    end,
}
