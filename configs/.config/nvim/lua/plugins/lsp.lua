return {
  -- LSP
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({
      ui = { border = "rounded" }
    })
    require("mason-lspconfig").setup({
      auto_install = true,
      ensure_installed = {
        "lua_ls", "intelephense", "cssls", "jsonls",
        "emmet_ls", "html", "pylsp", "sqlls", "biome", "gopls"
      },
    })
    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettierd", "stylua", "black", "isort", "sql-formatter", "biome", "gofumpt",
      },
    })
  end,
}
