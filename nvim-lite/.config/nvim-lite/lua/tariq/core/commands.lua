-- delete plugins
vim.api.nvim_create_user_command("PackDelete", function(info)
	-- Passes the argument from :PackDelete <plugin-name> into the API
	vim.pack.del(info.fargs, { force = info.bang })
end, {
	nargs = "+",
	bang = true,
	desc = "Permanently delete a vim.pack plugin from disk",
})

-- undo persistence
vim.api.nvim_create_autocmd("BufReadPre", {
	group = vim.api.nvim_create_augroup("persist_undo", {}),
	desc = "Persist undo history",
	pattern = "*",
	callback = function()
		vim.opt.undofile = true
	end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- remove trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("strip_trailing_whitespace", {}),
	desc = "Remove trailing whitespace on save",
	pattern = "*",
	callback = function()
		vim.cmd([[%s/\s\+$//e]])
	end,
})

-- set fold settings
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("fold_settings", {}),
	desc = "Set fold settings",
	pattern = "*",
	callback = function()
		vim.cmd([[setlocal foldlevel=99]])
		vim.cmd([[setlocal foldmethod=expr]])
		vim.cmd([[setlocal foldexpr=v:lua.vim.treesitter.foldexpr()]])
	end,
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})
