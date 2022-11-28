local M = {}

local function bind(op, outer_opts)
  outer_opts = outer_opts or {noremap = true}
  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force",
      outer_opts,
      opts or {}
    )
    vim.keymap.set(op, lhs, rhs, opts)
  end
end

M.nmap = bind("n", {noremap = false})
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")

vim.g.mapleader = " "
M.inoremap("jk", "<ESC>")
M.vnoremap("<leader>y", "\"+y")
M.nnoremap("<leader>/", ":nohlsearch<CR>")
M.nnoremap("<C-j>", "<C-w>j")
M.nnoremap("<C-k>", "<C-w>k")
M.nnoremap("<C-l>", "<C-w>l")
M.nnoremap("<C-h>", "<C-w>h")
M.nnoremap("<leader>r", ":so %<CR>")
M.nnoremap("<C-E>", ":Neotree show toggle=true<CR>")
M.nnoremap("<C-G>", ":Neotree float git_status toggle=true<CR>")

M.nnoremap("<C-p>", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>")
M.nnoremap("<leader>lg", ":Telescope live_grep<CR>")
M.nnoremap("<leader><C-p>", ":Telescope buffers<CR>")
M.nnoremap("<leader>fh", ":Telescope help_tags<CR>")
M.nnoremap("<leader>fr", ":Telescope lsp_references<CR>")
M.nnoremap("<leader>fd", ":Telescope lsp_definitions<CR>")
M.nnoremap("<C-f>", "<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({previewer = false, sorting_strategy = 'ascending', prompt_position = 'top' }))<CR>")


return M
