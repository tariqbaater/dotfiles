require("user")
require("user.remap")
require("user.options")
require("user.commands")

-- Load my custom Modules
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/user_functions", [[v:val =~ '\.lua$']])) do
  require("user_functions." .. file:gsub("%.lua$", ""))
end
-- Load my custom Plugins (its the same as laoding a lazy plugin from github)
local todo = require("user_functions.todo")
todo.setup({
  -- your custom options here
  target_file = "~/notes/todo.md",
})


require("user_functions.find-todos").setup()
