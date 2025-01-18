vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
-- show alpha dashboard
-- map("n", "<leader>h", ":Alpha<CR>", { noremap = true, silent = true })

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

-- harpoon keymaps
map(
    "n",
    "<leader>a",
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
