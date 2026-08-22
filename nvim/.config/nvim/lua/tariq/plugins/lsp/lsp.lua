return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "antosha417/nvim-lsp-file-operations",
    { "folke/lazydev.nvim", opts = {} },
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    local servers = {
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
    }

    for _, server in ipairs(servers) do
      local config = vim.lsp.config._configs[server]
      if not config then
        local files = vim.api.nvim_get_runtime_file("lsp/" .. server .. ".lua", false)
        if #files > 0 then
          config = dofile(files[1])
          if config and type(config) == "table" then
            vim.lsp.config(server, config)
          end
        end
      end
      pcall(vim.lsp.enable, server)
    end
  end,
}
