-- ==========================================================================
-- NATIVE FLOATING TERMINAL (PURE LUA RUNTIME)
-- ==========================================================================

local float_term_win = nil
local float_term_buf = nil

local function toggle_floating_terminal()
	-- If window exists and is valid, hide it (toggle off)
	if float_term_win and vim.api.nvim_win_is_valid(float_term_win) then
		vim.api.nvim_win_hide(float_term_win)
		float_term_win = nil
		return
	end

	-- Calculate centered dimensions (80% width, 80% height)
	local screen_width = vim.o.columns
	local screen_height = vim.o.lines
	local win_width = math.ceil(screen_width * 0.8)
	local win_height = math.ceil(screen_height * 0.8)
	local row = math.ceil((screen_height - win_height) / 2) - 1
	local col = math.ceil((screen_width - win_width) / 2)

	-- Window configuration options
	local win_opts = {
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	}

	-- Create or reuse buffer
	if not float_term_buf or not vim.api.nvim_buf_is_valid(float_term_buf) then
		float_term_buf = vim.api.nvim_create_buf(false, true)
	end

	-- Open the floating window
	float_term_win = vim.api.nvim_open_win(float_term_buf, true, win_opts)

	-- If it's a fresh buffer, spawn the native terminal shell inside it
	if vim.bo[float_term_buf].buftype ~= "terminal" then
		vim.cmd("terminal")
		vim.cmd("startinsert")
	else
		-- If reusing an existing shell, just drop back into insert mode
		vim.cmd("startinsert")
	end
end

-- Create a global user command so you can type :FloatTerm
vim.api.nvim_create_user_command("FloatTerm", toggle_floating_terminal, {})

-- Keymap to toggle it easily in Normal and Terminal modes (Ctrl+t)
vim.keymap.set({ "n", "t" }, "<C-t>", toggle_floating_terminal, { desc = "Toggle Native Floating Terminal" })
