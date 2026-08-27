vim.pack.add({ "https://github.com/07CalC/cook.nvim" })
require("cook").setup({
	runners = {
		lua = "lua %s",
		js = "node %s",
		php = "php %s",
		sh = "bash %s",
	},
})
