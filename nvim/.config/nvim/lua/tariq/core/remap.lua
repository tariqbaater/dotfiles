local map = vim.api.nvim_set_keymap

-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
	local venn_enabled = vim.inspect(vim.b.venn_enabled)
	if venn_enabled == "nil" then
		vim.b.venn_enabled = true
		vim.cmd([[setlocal ve=all]])
		-- draw a line on HJKL keystokes
		vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { silent = true, noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { silent = true, noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { silent = true, noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { silent = true, noremap = true })
		-- draw a box by pressing "f" with visual selection
		vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { silent = true, noremap = true })
	else
		vim.cmd([[setlocal ve=]])
		vim.api.nvim_buf_del_keymap(0, "n", "J")
		vim.api.nvim_buf_del_keymap(0, "n", "K")
		vim.api.nvim_buf_del_keymap(0, "n", "L")
		vim.api.nvim_buf_del_keymap(0, "n", "H")
		vim.api.nvim_buf_del_keymap(0, "v", "f")
		vim.b.venn_enabled = nil
	end
end
-- toggle keymappings for venn
vim.api.nvim_set_keymap("n", "<leader>ve", ":lua Toggle_venn()<CR>", { noremap = true })

-- sed search and replace
map(
	"n",
	"<leader>R",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor is on globally" }
)

-- delete text without yanking into register
map("n", "<leader>d", '"_d', { desc = "Delete without yanking" })

-- make current file executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- cursor positioning
map("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
map("n", "n", "nzzzv", { desc = "move to next search result with cursor centered" })
map("n", "N", "Nzzzv", { desc = "move to previous search result with cursor centered" })

-- Obsidian
map(
	"n",
	"<leader>ov",
	':Telescope find_files search_dirs={"/Users/tariq/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/Vault"}<cr>',
	{ noremap = true, silent = true, desc = "Open Obsidian notes" }
)

map(
	"n",
	"<leader>oz",
	':Telescope live_grep search_dirs={"/Users/tariq/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/Vault"}<cr>',
	{ noremap = true, silent = true, desc = "Open Obsidian notes" }
)
-- move file in current buffer to zettelkasten folder
map(
	"n",
	"<leader>ok",
	":!mv '%:p' /Users/tariq/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/Vault/zettelkasten<cr>:bd<cr>",
	{ noremap = true, silent = true, desc = "Move file to zettelkasten folder" }
)
-- delete file in current buffer
map(
	"n",
	"<leader>odd",
	":!rm '%:p'<cr>:bd<cr>",
	{ noremap = true, silent = true, desc = "Delete file in current buffer" }
)
-- navigate to vault
map(
	"n",
	"<leader>oc",
	":cd /Users/tariq/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/Vault<cr>",
	{ noremap = true, silent = true, desc = "Change directory to Obsidian vault" }
)

-- copen navigation
map("n", "<leader>C", ":copen<CR>", { noremap = true, silent = true, desc = "Open quickfix list" })
map("n", "<leader>C<CR>", ":cclose<CR>", { noremap = true, silent = true, desc = "Close quickfix list" })
map("n", "§", ":cnext<CR>", { noremap = true, silent = true, desc = "Next quickfix item" })
map("n", "±", ":cprev<CR>", { noremap = true, silent = true, desc = "Previous quickfix item" })

-- Quickly append semicolon or comma in insert mode
-- vim.keymap.set("i", ";;", "<Esc>A:<Esc>")
-- vim.keymap.set("i", ",,", "<Esc>A,<Esc>")
-- vim.keymap.set("i", "))", "<Esc>A)<Esc>")

-- -- Open in finder
-- vim.keymap.set("n", "<Leader><Leader>O", ":!open $PWD<CR><CR>", { silent = true })

-- Open line, but stay in normal mode
vim.keymap.set("n", "<CR>", "o<Esc>")

-- Keep visual selection when indenting
vim.keymap.set("x", ">", ">gv")
vim.keymap.set("x", "<", "<gv")

-- increment/decrement numbers
map("n", "<leader>=", "<C-a>", { noremap = true, silent = true, desc = "Increment number" }) -- increment
map("n", "<leader>-", "<C-x>", { noremap = true, silent = true, desc = "Decrement number" }) -- decrement

-- normal mode
map("i", "jk", "<ESC>", { noremap = true, silent = true })
map("i", "kj", "<ESC>", { noremap = true, silent = true })

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

-- windows resize
vim.keymap.set("n", "<leader><left>", ":vertical resize +20<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><right>", ":vertical resize -20<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><up>", ":resize +10<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><down>", ":resize -10<cr>", { noremap = true, silent = true })
