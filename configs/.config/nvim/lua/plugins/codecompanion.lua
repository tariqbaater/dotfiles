return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        llama3 = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "llama3", -- Give this adapter a different name to differentiate it from the default ollama adapter
            schema = {
              model = {
                default = "llama3:instruct",
              },
              num_ctx = {
                default = 16384,
              },
              num_predict = {
                default = -1,
              },
            },
          })
        end,
      },
    })
  end,
}
