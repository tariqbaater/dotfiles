-- custom line commands

-- lsp options
-- create a command to toggle diagnostics
vim.api.nvim_create_user_command("ToggleDiagnostics", function()
  local current_state = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not current_state, underline = not current_state })
  if not current_state then
    print("Diagnostics enabled")
  else
    print("Diagnostics disabled")
  end
end, {})

-- undo persistence
vim.api.nvim_create_autocmd("BufReadPre", {
  group = vim.api.nvim_create_augroup("persist_undo", {}),
  desc = "Persist undo history",
  pattern = "*",
  callback = function()
    vim.opt.undofile = true
  end,
})

-- config
vim.api.nvim_create_user_command("Config", function()
  vim.cmd([[cd ~/.config/nvim]])
  vim.cmd("Telescope find_files")
end, {})

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

-- terminal settings
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("terminal_settings", {}),
  desc = "Terminal settings",
  pattern = "*",
  callback = function()
    vim.cmd([[startinsert]])
    vim.cmd([[setlocal signcolumn=no]])
    vim.cmd([[setlocal nonumber norelativenumber]])
    vim.cmd([[setlocal foldcolumn=0]])
    -- split below the same window
    vim.cmd([[setlocal splitbelow]])
    -- set terminal size to 10 lines, **I disabeld this because it breaks lazygit inside neovim**
    -- vim.cmd([[resize 10]])
    -- open terminal in insert mode
    vim.cmd([[setlocal filetype=terminal]])
    vim.cmd([[setlocal statusline=%{get(b:,'coc_current_function','')}]])
    -- move between terminal windows
    vim.cmd([[tnoremap <buffer> <c-h> <c-\><c-n><c-w>h]])
    vim.cmd([[tnoremap <buffer> <c-j> <c-\><c-n><c-w>j]])
    vim.cmd([[tnoremap <buffer> <c-k> <c-\><c-n><c-w>k]])
    vim.cmd([[tnoremap <buffer> <c-l> <c-\><c-n><c-w>l]])
  end,
})

-- when a markdown file is opened, set wrap and spelling
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("markdown_settings", {}),
  desc = "Markdown settings",
  pattern = "markdown",
  callback = function()
    vim.cmd([[setlocal wrap]])
    vim.cmd([[setlocal spell]])
  end,
})

-- return to insert mode on buffer enter in terminals
vim.api.nvim_create_autocmd("WinEnter", {
  group = vim.api.nvim_create_augroup("terminal_return", {}),
  desc = "Return to insert mode on buffer enter in terminals",
  pattern = "term://*",
  callback = function()
    vim.cmd([[startinsert]])
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
    vim.cmd([[setlocal foldexpr=nvim_treesitter#foldexpr()]])
  end,
})

--  Disable arrow keys in all modes
local modes = { "n", "i", "v", "x", "s", "o", "t" } -- all possible modes
local arrows = { "<Up>", "<Down>", "<Left>", "<Right>" }

for _, mode in ipairs(modes) do
  for _, key in ipairs(arrows) do
    vim.keymap.set(mode, key, "<Nop>", { noremap = true, silent = true })
  end
end

-- local enabledModes = { "i", "c", "t", "o", "t", "s", "x" } -- modes where arrow keys are enabled
-- -- Map alt + h/j/k/l to arrow keys in insert mode
-- for _, mode in ipairs(enabledModes) do
--   vim.keymap.set(mode, "<A-h>", "<Left>", { noremap = true, silent = true })
--   vim.keymap.set(mode, "<A-j>", "<Down>", { noremap = true, silent = true })
--   vim.keymap.set(mode, "<A-k>", "<Up>", { noremap = true, silent = true })
--   vim.keymap.set(mode, "<A-l>", "<Right>", { noremap = true, silent = true })
-- end

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- source lua files on save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.lua",
  callback = function()
    vim.cmd("source %")
    print("Sourced " .. vim.fn.expand("%"))
  end,
})

-- when lazygit is opened within neovim, set the size to 30 lines
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("lazygit_size", {}),
  desc = "Lazygit size",
  pattern = "*lazygit*",
  callback = function()
    vim.cmd([[resize 36]])
  end,
})

-- save macros that are triggered when entering a buffer
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("save_macros", {}),
  desc = "Save macros",
  pattern = "*",
  callback = function()
    -- update your favorite macros here
    -- make the current line in markdown into a checkbox
    vim.fn.setreg("c", "0I- [ �kb �kr�kbf]��5a j")
    -- mark as completed checkbox
    vim.fn.setreg("x", "02f ��5rx��50j")
    -- bold
    vim.fn.setreg("b", "0i**A**0")
    -- italic
    vim.fn.setreg("i", "0i*A*0")
    -- list item
    vim.fn.setreg("l", "0I- 0")
  end,
})

-- Patch neocodeium for SQL temp buffers and mysql filetype alias
-- These plugin files are overwritten on :LazySync, so we re-patch after updates
local function patch_neocodeium()
  local ok, result = pcall(function()
    -- Add mysql -> sql alias in filetype.lua
    local ft_path = vim.fn.stdpath("data") .. "/lazy/neocodeium/lua/neocodeium/filetype.lua"
    local ft_content = vim.fn.readfile(ft_path)
    local has_mysql = false
    for _, line in ipairs(ft_content) do
      if line:find("mysql") then
        has_mysql = true
        break
      end
    end
    if not has_mysql then
      for i, line in ipairs(ft_content) do
        if line:find("bash%s*=%s*'shell'") then
          table.insert(ft_content, i, "   mysql           = 'sql',")
          break
        end
      end
      vim.fn.writefile(ft_content, ft_path)
    end

    -- Patch workspace_uri in doc.lua to use buffer-local dir
    local doc_path = vim.fn.stdpath("data") .. "/lazy/neocodeium/lua/neocodeium/doc.lua"
    local doc_content = table.concat(vim.fn.readfile(doc_path), "\n")

    local needs_fn_import = not doc_content:find("local fn = vim.fn")
    local needs_workspace_fix = doc_content:find("state%.project_root_uri")

    if needs_fn_import then
      doc_content = doc_content:gsub("local api = vim%.api", "local api = vim.api\nlocal fn = vim.fn")
    end

    if needs_workspace_fix then
      doc_content = doc_content:gsub(
        "local name = api%.nvim_buf_get_name%(buf%)%s*\n%s*local lang",
        'local name = api.nvim_buf_get_name(buf)\n   local abs_name = fn.fnamemodify(name, ":p")\n   local buf_dir = fn.fnamemodify(abs_name, ":h")\n   local lang'
      )
      doc_content = doc_content:gsub("workspace_uri = state%.project_root_uri", "workspace_uri = stdio.to_uri(buf_dir)")
      doc_content = doc_content:gsub("absolute_uri = stdio%.to_uri%(name%)", "absolute_uri = stdio.to_uri(abs_name)")
    end

    vim.fn.writefile(vim.split(doc_content, "\n"), doc_path)
  end)
  if not ok then
    vim.notify("neocodeium patch failed: " .. tostring(result), vim.log.levels.WARN)
  end
end

patch_neocodeium()

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("neocodeium_patch", {}),
  desc = "Re-patch neocodeium after lazy updates",
  pattern = { "LazyUpdate", "LazyInstall", "LazySync" },
  callback = patch_neocodeium,
})
