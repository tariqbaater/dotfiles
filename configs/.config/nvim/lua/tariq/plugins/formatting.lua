return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      stylua = {},
      isort = {},
      black = { prepend_args = { "--fast" } },
      prettierd = {},
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      html = { "prettierd" },
      css = { "prettierd" },
      json = { "prettierd" },
      markdown = { "prettierd" },
    },
  },
}
