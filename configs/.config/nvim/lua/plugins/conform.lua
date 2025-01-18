return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				lua = { "stylua" },
				python = { "black", "isort" },
				rust = { "rustfmt" },
				cpp = { "clang-format" },
				sql = { "sleek" },
			},
			-- format_on_save = {
			-- 	lsp_fallback = true,
			-- 	async = true,
			-- 	timeout_ms = 1000,
			-- },
		})

		vim.keymap.set("n", "<leader>.", function()
			conform.format({
				lsp_fallback = true,
				async = true,
				timeout_ms = 1000,
			})
		end, { desc = "Format file" })
	end,
}
