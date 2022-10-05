local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local loudopts = { noremap = true, silent = false }

vim.g.mapleader = " "
map("i", "jk", "<ESC>", opts)
map("v", "<leader>y", "\"+y", loudopts)
map("n", "<leader>/", ":nohlsearch<CR>", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<leader>r", ":so %<CR>", opts)
map("n", "<C-E>", ":Neotree show toggle=true<CR>", opts)
map("n", "<C-G>", ":Neotree float git_status toggle=true<CR>", opts)

map("n", "<C-p>", ":Telescope find_files<CR>", opts)
map("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

