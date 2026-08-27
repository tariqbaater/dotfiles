-- lsp
vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
vim.diagnostic.config({ virtual_text = true})

-- set numbers and relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tabs and spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 100 -- set text width for automatic line breaks

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

-- mouse
vim.opt.mouse = "a"

-- cursor line
vim.opt.cursorline = true

-- comfigure how new splits open
vim.opt.splitbelow = true
vim.opt.splitright = true

-- signcolumn
vim.opt.signcolumn = "yes"

-- set fold column
vim.opt.foldcolumn = "1"
vim.opt.foldmethod = "marker" -- change to indent for folding

-- save undo history
vim.opt.undofile = true

-- set status line
vim.opt.laststatus = 3

-- name terminal buffer
vim.opt.title = true

-- disable mode indicator
vim.opt.showmode = false

-- set confirmation dialog
vim.opt.confirm = true

-- set incommand
vim.opt.inccommand = "split"
