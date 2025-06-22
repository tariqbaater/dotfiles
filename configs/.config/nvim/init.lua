require("user")
require("user.remap")
require("user.options")
require("user.commands")

-- Load my custom Modules
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/user_functions", [[v:val =~ '\.lua$']])) do
  require("user_functions." .. file:gsub("%.lua$", ""))
end
