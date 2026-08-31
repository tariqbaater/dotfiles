return {
	"echasnovski/mini.nvim",
	event = "VeryLazy",
	config = function()
		require("mini.indentscope").setup({
			symbol = "│",
			options = { try_as_border = true },
		})
		require("mini.surround").setup({
			mappings = {
				add = "ys",
				delete = "ds",
				find = "fs",
				find_left = "fs",
				highlight = "hs",
				replace = "cs",
				update_n_lines = "sn",
			},
			search_method = "cover_or_nearest",
		})
		require("mini.comment").setup({})
		require("mini.sessions").setup({
			autowrite = true,
			autoread = true,
			silent = true,
		})
	end,
}
