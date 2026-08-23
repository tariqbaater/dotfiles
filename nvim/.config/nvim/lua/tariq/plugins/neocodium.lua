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

		-- Runtime overrides (no plugin file edits, so updates work):
		local filetype = require("neocodeium.filetype")
		filetype.aliases.mysql = "sql"

		local stdio = require("neocodeium.utils.stdio")
		local doc = require("neocodeium.doc")
		local orig_get = doc.get
		doc.get = function(buf, ft, max_lines, pos)
			local data = orig_get(buf, ft, max_lines, pos)
			local name = vim.api.nvim_buf_get_name(buf)
			local abs_name = vim.fn.fnamemodify(name, ":p")
			data.absolute_uri = stdio.to_uri(abs_name)
			data.workspace_uri = stdio.to_uri(vim.fn.fnamemodify(abs_name, ":h"))
			return data
		end

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
