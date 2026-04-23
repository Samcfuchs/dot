-- leader
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- space as leader
vim.keymap.set({ "n", "v" }, "<Space>", "<leader>", { remap = true })

-- escape shortcuts
vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("i", "jk", "<esc>")

-- blank line above/below without entering insert mode
vim.keymap.set("n", "<leader>o", "o<esc>")
vim.keymap.set("n", "<leader>O", "O<esc>")

-- yank to end of line
vim.keymap.set("n", "Y", "y$")

-- buffer navigation
vim.keymap.set("n", "<C-n>", "<cmd>bn<cr>")
vim.keymap.set("n", "<C-p>", "<cmd>bp<cr>")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<c-p>", ":Telescope<cr>")

vim.keymap.set("n", "<leader>=", ":vertical resize +5<cr>", { desc = "Increase the width of the current split" })
vim.keymap.set("n", "<leader>-", ":vertical resize -5<cr>", { desc = "Decrease the width of the current split" })

vim.keymap.set("n", "<c-_>", ":Neotree toggle left<cr>", { desc = "Open or close the neo-tree pane" })
vim.keymap.set("n", "<c-o>", ":Telescope find_files<cr>")
vim.keymap.set("n", "git", ":Neotree float git_status<cr>")
