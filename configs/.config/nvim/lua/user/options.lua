-- set leader key to space
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`
vim.g.mapleader = " "       -- Make sure to set `mapleader` before lazy so your mappings are correct

-- lazygit options
vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' } -- customize lazygit popup window border characters
vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
vim.g.lazygit_config_file_path = '' -- custom config file path
-- OR
vim.g.lazygit_config_file_path = {} -- table of custom config file paths


-- Neovim default updatetime is 4000 set to lower value to update perfomance
vim.opt.updatetime = 200



-- set numbers and relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tabs and spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- line wrapping
vim.opt.wrap = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.clipboard = "unnamedplus"

-- colors
vim.opt.termguicolors = true
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

-- mouse
vim.opt.mouse = "a"

-- cursor line
vim.opt.cursorline = true

-- comfigure how new splits open
vim.opt.splitbelow = true
vim.opt.splitright = true

-- signcolumn
vim.opt.signcolumn = "yes"

-- %s/old/new/g - replace all old with new, g is for global and % is for all lines

-- set fold column
vim.opt.foldcolumn = "1"
vim.opt.foldmethod = "marker" -- change to indent for folding

-- save undo history
vim.opt.undofile = true

-- set status line
vim.opt.laststatus = 3

-- name terminal buffer
vim.opt.title = true

-- set cursor shape
vim.opt.guicursor =
"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- disable mode indicator
vim.opt.showmode = false

-- set confirmation dialog
vim.opt.confirm = true

-- set incommand
vim.opt.inccommand = "split"
