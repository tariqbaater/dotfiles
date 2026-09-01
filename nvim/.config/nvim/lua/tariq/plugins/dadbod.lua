return {
  { "tpope/vim-dadbod", cmd = "DB" },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = "DBUIToggle",
    dependencies = { "tpope/vim-dadbod" },
  },
  { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "postgres" } },
}
