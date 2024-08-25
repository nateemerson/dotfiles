require'nvim-tree'.setup {
  filters = {
    custom = {".git", "node_modules", ".vscode"}
  },
  git = {
    ignore = true
  },
  view = {
    float = {
      enable = true,
    }
  }
}
vim.keymap.set('n', '<C-s>', vim.cmd.NvimTreeToggle)
vim.keymap.set('n', '<leader>ff', vim.cmd.NvimTreeFindFile)
