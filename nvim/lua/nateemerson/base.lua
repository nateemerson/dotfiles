-- Credit to @ThePrimeagen and @k1ng440

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local options = {
  fileencoding = "utf-8",

  backup = false,
  swapfile = false,
  undofile = true,
  undodir = os.getenv("HOME") .. "/.vim/undodir",

  writebackup = false,
  clipboard = "unnamedplus",
  nu = true,
  rnu = true,
  cursorline = true,
  guicursor = "",

  errorbells = false,

  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,

  smartindent = true,
  smartcase = true,

  wrap = false,

  scrolloff = 8,
  sidescrolloff = 8,
  signcolumn = "yes",

  cmdheight = 1,
  numberwidth = 4,

  updatetime = 50,
  timeoutlen = 1000,

  showmode = false,
  showtabline = 2,
  splitbelow = true,
  splitright = true,
  colorcolumn = "80",
  termguicolors = true,

  wildmenu = true,

  ignorecase = true,
  hlsearch = true,
  incsearch = true,

  
  conceallevel = 0 -- so that `` is visible in md files (credit LunarVim)
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.isfname:append("@-@")
vim.opt.shortmess:append("c")
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
