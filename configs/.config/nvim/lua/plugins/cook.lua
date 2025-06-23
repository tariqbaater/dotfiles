return {

  "07CalC/cook.nvim",
  config = function()
    require("cook").setup({
      runners = {
        lua = "'lua %s'",
        js = "'node %s'",
        php = "'php %s'",
      }
    })
  end,
  cmd = "Cook",
}
