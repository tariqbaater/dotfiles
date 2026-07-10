return {
  "monkoose/neocodeium",
  event = "InsertEnter",
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup({
      filetypes = {
        sql = true,
        sqlite = true,
        mysql = true,
        plsql = true,
        lua = true,
      },
    })
    -- vim.keymap.set("i", "<a-f>", neocodeium.accept)
    vim.keymap.set("i", "<Tab>", function()
      require("neocodeium").accept()
    end)
    vim.keymap.set("i", "<A-w>", function()
      require("neocodeium").accept_word()
    end)
    vim.keymap.set("i", "<A-a>", function()
      require("neocodeium").accept_line()
    end)
    vim.keymap.set("i", "<A-e>", function()
      require("neocodeium").cycle_or_complete()
    end)
    vim.keymap.set("i", "<A-r>", function()
      require("neocodeium").cycle_or_complete(-1)
    end)
    vim.keymap.set("i", "<A-c>", function()
      require("neocodeium").clear()
    end)
  end,
}
