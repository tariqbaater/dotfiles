vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap

-- sed search and replace
map("n", "<leader>R", ":%s/<C-R><C-W>/<C-R>0/g<CR>",
  { noremap = true, silent = true, desc = "Search and replace word under cursor" })

-- Obsidian
map("n", "<leader>ov",
  ":Telescope find_files search_dirs={\"/Users/tariq/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/Vault\"}<cr>",
  { noremap = true, silent = true, desc = "Open Obsidian notes" })

map("n", "<leader>oz",
  ":Telescope live_grep search_dirs={\"/Users/tariq/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/Vault\"}<cr>",
  { noremap = true, silent = true, desc = "Open Obsidian notes" })
-- move file in current buffer to zettelkasten folder
map("n", "<leader>ok",
  ":!mv '%:p' /Users/tariq/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/Vault/zettelkasten<cr>:bd<cr>",
  { noremap = true, silent = true, desc = "Move file to zettelkasten folder" })
-- delete file in current buffer
map("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>",
  { noremap = true, silent = true, desc = "Delete file in current buffer" })
-- navigate to vault
map("n", "<leader>oc",
  ":cd /Users/tariq/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/Vault<cr>",
  { noremap = true, silent = true, desc = "Change directory to Obsidian vault" })

-- copen navigation
map("n", "<leader>C", ":copen<CR>", { noremap = true, silent = true, desc = "Open quickfix list" })
map("n", "<leader>C<CR>", ":cclose<CR>", { noremap = true, silent = true, desc = "Close quickfix list" })
map("n", "§", ":cnext<CR>", { noremap = true, silent = true, desc = "Next quickfix item" })
map("n", "±", ":cprev<CR>", { noremap = true, silent = true, desc = "Previous quickfix item" })

-- Quickly append semicolon or comma in insert mode
vim.keymap.set('i', ';;', '<Esc>A:<Esc>')
vim.keymap.set('i', ',,', '<Esc>A,<Esc>')
vim.keymap.set('i', '))', '<Esc>A)<Esc>')

-- Open in finder
vim.keymap.set('n', '<Leader><Leader>o', ':!open $PWD<CR><CR>', { silent = true })

-- Open line, but stay in normal mode
vim.keymap.set('n', '<CR>', 'o<Esc>')

-- Keep visual selection when indenting
vim.keymap.set('x', '>', '>gv')
vim.keymap.set('x', '<', '<gv')

-- increment/decrement numbers
map("n", "<leader>+", "<C-a>", { noremap = true, silent = true, desc = "Increment number" }) -- increment
map("n", "<leader>-", "<C-x>", { noremap = true, silent = true, desc = "Decrement number" }) -- decrement

-- normal mode
map("i", "jk", "<ESC>", { noremap = true, silent = true })
map("i", "jj", "<ESC>", { noremap = true, silent = true })
map("i", "kj", "<ESC>", { noremap = true, silent = true })
map("i", "kk", "<ESC>", { noremap = true, silent = true })

-- cycle buffers
map("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
map("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true })

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

-- windows
vim.keymap.set("n", "<leader><left>", ":vertical resize +20<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><right>", ":vertical resize -20<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><up>", ":resize +10<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><down>", ":resize -10<cr>", { noremap = true, silent = true })

-- harpoon keymaps
map(
  "n",
  "<leader>A",
  ":lua require('harpoon.mark').add_file()<CR>",
  { noremap = true, silent = true, desc = "add file to harpoon" }
)
map(
  "n",
  "<C-e>",
  ":lua require('harpoon.ui').toggle_quick_menu()<CR>",
  { noremap = true, silent = true, desc = "toggle harpoon menu" }
)
map(
  "n",
  "<C-p>",
  ":lua require('harpoon.ui').nav_prev()<CR>",
  { noremap = true, silent = true, desc = "navigate to previous mark" }
)
map(
  "n",
  "<C-h>",
  ":lua require('harpoon.ui').nav_next()<CR>",
  { noremap = true, silent = true, desc = "navigate to next mark" }
)

map(
  "n",
  "<leader>1",
  ":lua require('harpoon.ui').nav_file(1)<CR>",
  { noremap = true, silent = true, desc = "navigate to file 1" }
)
map(
  "n",
  "<leader>2",
  ":lua require('harpoon.ui').nav_file(2)<CR>",
  { noremap = true, silent = true, desc = "navigate to file 2" }
)
map(
  "n",
  "<leader>3",
  ":lua require('harpoon.ui').nav_file(3)<CR>",
  { noremap = true, silent = true, desc = "navigate to file 3" }
)
map(
  "n",
  "<leader>4",
  ":lua require('harpoon.ui').nav_file(4)<CR>",
  { noremap = true, silent = true, desc = "navigate to file 4" }
)
map(
  "n",
  "<leader>5",
  ":lua require('harpoon.ui').nav_file(5)<CR>",
  { noremap = true, silent = true, desc = "navigate to file 5" }
)
