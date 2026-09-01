return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "MasonInstall", "MasonUninstall", "MasonUpdate", "LspInstall", "LspInstallInfo" },
    opts = {
      ensure_installed = {
        "ts_ls",
        "ruff",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "emmet_ls",
        "prismals",
        "pyright",
        "eslint",
      },
    },
    dependencies = {
      "mason-org/mason.nvim",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
    opts = {
      ensure_installed = {
        "prettier",
        "stylua",
        "isort",
        "black",
        "pylint",
        "eslint_d",
      },
    },
    dependencies = {
      "mason-org/mason.nvim",
    },
  },
}
