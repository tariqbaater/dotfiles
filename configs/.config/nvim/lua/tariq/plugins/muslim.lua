return {
  "awesomegeek/prayertime.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
  priority = 1000,
  opts = {
    city = "Riyadh",
    coords = { "24.690051185803423", "46.720008008708696" },
    method = 4, -- MWL
  },
  keys = {
    { "<leader>pt", "<cmd>SalatPopup<cr>", desc = "Show Prayer Time Popup" },
  },
}
