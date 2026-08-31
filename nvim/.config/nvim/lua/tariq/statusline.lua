-- ==========================================================================
-- NEOVIM 0.12+ NATIVE STATUSLINE (NO PLUGINS)
-- ==========================================================================

-- Always display the statusline
vim.opt.laststatus = 2

-- Define highlight groups for sections (Adjust colors as desired)
vim.api.nvim_set_hl(0, "StatusLineMode", { fg = "#1e1e2e", bg = "#b4befe", bold = true })
vim.api.nvim_set_hl(0, "StatusLineGit", { fg = "#a6e3a1", bg = "#313244" })
vim.api.nvim_set_hl(0, "StatusLineFile", { fg = "#CDD6F4", bg = "#1e1e2e", bold = true })
vim.api.nvim_set_hl(0, "StatusLineDiagErr", { fg = "#f38ba8", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "StatusLineDiagWarn", { fg = "#f9e2af", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "StatusLineProgress", { fg = "#89B4FA", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "StatusLinePomo", { fg = "#f38ba8", bg = "#1e1e2e" })

-- Helper map for Vim modes
local modes = {
	["n"] = " NORMAL ",
	["no"] = " N-PEND ",
	["v"] = " VISUAL ",
	["V"] = " V-LINE ",
	["\22"] = " V-BLOCK ",
	["s"] = " SELECT ",
	["S"] = " S-LINE ",
	["\19"] = " S-BLOCK ",
	["i"] = " INSERT ",
	["ic"] = " I-COMP ",
	["R"] = " REPLACE ",
	["Rv"] = " V-REPLACE ",
	["c"] = " COMMAND ",
	["cv"] = " V-EX ",
	["ce"] = " EX ",
	["r"] = " PROMPT ",
	["rm"] = " MORE ",
	["r?"] = " CONFIRM ",
	["!"] = " SHELL ",
	["t"] = " TERMINAL ",
}

-- 1. Mode component
local function get_mode()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format("%%#StatusLineMode#%s%%*", modes[current_mode] or " UNKNOWN ")
end

-- 2. Git Branch component (using native gitsigns if available, or empty string)
local function get_git()
	local head = vim.b.gitsigns_head or vim.g.actual_curbuf and vim.b[vim.g.actual_curbuf].gitsigns_head
	if head and head ~= "" then
		return string.format("%%#StatusLineGit#  %s %%*", head)
	end
	return ""
end

-- 3. File Info component (Name, Modified flag, Read-Only flag)
local function get_file_info()
	return "%#StatusLineFile# %f %m%r %*"
end

-- 4. Native Diagnostics component (Neovim 0.12+ status API)
local function get_diagnostics()
	-- Utilizes the native status utility updated in newer Neovim versions
	if not vim.diagnostic.is_enabled() then
		return ""
	end

	local count = vim.diagnostic.count(0)
	local result = {}

	if count[vim.diagnostic.severity.ERROR] then
		table.insert(result, string.format("%%#StatusLineDiagErr# %d%%*", count[vim.diagnostic.severity.ERROR]))
	end
	if count[vim.diagnostic.severity.WARN] then
		table.insert(result, string.format("%%#StatusLineDiagWarn# %d%%*", count[vim.diagnostic.severity.WARN]))
	end

	return #result > 0 and (" " .. table.concat(result, " ")) or ""
end

-- 5. Native LSP Progress component (Neovim 0.12+ vim.ui.progress integration)
local function get_lsp_progress()
	-- Checks if there are active progress logs for the current buffer
	local progress = vim.lsp.status and vim.lsp.status() or ""
	if progress ~= "" then
		return string.format("%%#StatusLineProgress#  %s %%*", progress)
	end
	-- Fallback: If no background progress, show the names of attached LSP clients
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients > 0 then
		local names = {}
		for _, client in ipairs(clients) do
			table.insert(names, client.name)
		end
		return string.format("%%#StatusLineProgress#  %s %%*", table.concat(names, ","))
	end

	return ""
end

-- 6. Helper: Pomodoro status display (string.format optimized)
local function pomodoro_status()
	local ok, pomo = pcall(require, "pomo")

	-- Case 1: Plugin is not installed or failed to load
	if not ok then
		return string.format("%%#StatusLinePomo# 󰄉 --:-- %%*")
	end

	local timer = pomo.get_first_to_finish()

	-- Case 2: Plugin is loaded and an active timer is running
	if timer then
		return string.format("%%#StatusLinePomo# 󰄉 %s %%*", tostring(timer))
	end

	-- Case 3: Plugin is loaded but no timer is running
	return string.format("%%#StatusLinePomo# 󰄉 --:-- %%*")
end

-- Assemble the final active statusline structure
function _G.custom_statusline()
	return table.concat({
		get_mode(),
		get_git(),
		get_file_info(),
		get_diagnostics(),
		"%=", -- Right align delimiter spacer
		pomodoro_status(),
		get_lsp_progress(),
		-- "%#StatusLineFile# %l:%c %P %%*", -- Position: Line, Column, and Percentage
	})
end

-- Set the global statusline option to call our Lua evaluator function
vim.opt.statusline = "%!v:lua.custom_statusline()"
