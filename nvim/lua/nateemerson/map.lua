local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local loudopts = { noremap = true, silent = false }

vim.g.mapleader = " "
map("i", "jk", "<ESC>", opts)
map("v", "<leader>y", "\"+y", loudopts)
map("n", "<leader>/", ":nohlsearch<CR>", opts)
map("n", "<C-j>", "<C-w><C-j>", opts)
map("n", "<C-k>", "<C-w><C-k>", opts)
map("n", "<C-l>", "<C-w><C-l>", opts)
map("n", "<C-h>", "<C-w><C-h>", opts)

