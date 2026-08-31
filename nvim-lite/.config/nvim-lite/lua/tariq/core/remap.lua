vim.g.mapleader = " "

local map = vim.keymap.set
-- undo tree
map("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Open undo tree" })

-- find files like telescope picker
map("n", "<leader>ff", ":Pick files<CR>", { silent = true, desc = "Find files in the current directory" })
map("n", "<leader>fg", ":Pick grep_live<CR>", { silent = true, desc = "Find words in the current directory" })
map("n", "<leader>fb", ":Pick buffers<CR>", { silent = true, desc = "Find buffers in the current directory" })
map("n", "<leader>fr", ":Pick resume<CR>", { silent = true, desc = "Find recent files" })

-- Home Screen
map("n", "<leader>h", ":lua MiniStarter.open()<CR>", { desc = "Open Starter" })

-- DadBod UI
map("n", "<leader>m", ":DBUIToggle<CR>", { desc = "Deploy DBUI" })

-- Run program files (cook)
map("n", "<leader>r", ":Cook<CR>", { desc = "Run program" })

-- LazyGit
map("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit" })

-- vim pack
map("n", "<leader>pa", ":lua vim.pack.update()<CR>", { silent = true, desc = "Update plugins" })

-- diagnostics
vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.setqflist()
	vim.cmd("copen")
end, { silent = true, desc = "Lsp Diagnostics" })

-- copen navigation
map("n", "<leader>C", ":copen<CR>", { noremap = true, silent = true, desc = "Open quickfix list" })
map("n", "§", ":cnext<CR>", { noremap = true, silent = true, desc = "Next quickfix item" })
map("n", "±", ":cprev<CR>", { noremap = true, silent = true, desc = "Previous quickfix item" })

-- file explorer
map("n", "<leader>e", ":Oil<CR>", { noremap = true, silent = true, desc = "Mini files" })
-- sed search and replace
map("n", "<leader>R", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word" })

-- make current file executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "make executable" })

-- cursor positioning
map("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
map("n", "n", "nzzzv", { desc = "move to next search result with cursor centered" })
map("n", "N", "Nzzzv", { desc = "move to previous search result with cursor centered" })

-- Open line, but stay in normal mode
vim.keymap.set("n", "<CR>", "o<Esc>")

-- Keep visual selection when indenting
vim.keymap.set("x", ">", ">gv")
vim.keymap.set("x", "<", "<gv")

-- increment/decrement numbers
map("n", "<leader>+", "<C-a>", { noremap = true, silent = true, desc = "Increment number" }) -- increment
map("n", "<leader>-", "<C-x>", { noremap = true, silent = true, desc = "Decrement number" }) -- decrement

-- normal mode
map("i", "jk", "<ESC>", { noremap = true, silent = true })
map("i", "kj", "<ESC>", { noremap = true, silent = true })
map("i", "<C-c>", "<ESC>", { noremap = true, silent = true })

-- cycle buffers
map("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
map("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true })

-- buffers
map("n", "<leader>c", ":bd<CR>", { noremap = true, silent = true, desc = "Close buffer" })
map("n", "<leader>s", ":w<cr>", { noremap = true, silent = true, desc = "Save buffer" })
map("n", "<leader>n", "<cmd>enew<CR>", { noremap = true, silent = true, desc = "New Buffer" })
map("n", "<leader>q", "<cmd>q<cr>", { noremap = true, silent = true, desc = "Quit" })

-- move lines up and down
map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- move to first non-blank character of line
map("n", "<BS>", "^", { noremap = true, silent = true, desc = "move to first non-blank character of line" })

-- move between windows
map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- splits
map("n", "<leader>wv", ":vsp new<CR>", { noremap = true, silent = true, desc = "Vertical split" })
map("n", "<leader>wh", ":split new<CR>", { noremap = true, silent = true, desc = "Horizontal split" })

-- windows
vim.keymap.set(
	"n",
	"<leader><left>",
	":vertical resize +20<cr>",
	{ noremap = true, silent = true, desc = "Vert resize +20" }
)
vim.keymap.set(
	"n",
	"<leader><right>",
	":vertical resize -20<cr>",
	{ noremap = true, silent = true, desc = "Vert resize -20" }
)
vim.keymap.set("n", "<leader><up>", ":resize +10<cr>", { noremap = true, silent = true, desc = "Horiz resize +10" })
vim.keymap.set("n", "<leader><down>", ":resize -10<cr>", { noremap = true, silent = true, desc = "Horiz resize -10" })
