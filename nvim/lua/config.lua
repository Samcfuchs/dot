vim.g.have_nerd_font = true
vim.o.number = true
vim.o.cursorline = true
vim.o.scrolloff = 10

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.opt.signcolumn = "yes"
vim.diagnostic.config({ update_in_insert = false })

vim.o.showmode = false
vim.o.undofile = true
vim.o.inccommand = "split"

vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopeLoad",
	once = true,
	callback = function()
		pcall(require("telescope").load_extension, "projects")
		pcall(require("telescope").load_extension, "sessions-picker")
	end,
})
