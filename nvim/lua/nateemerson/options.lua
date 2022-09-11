-- Credit to @ThePrimeagen and @k1ng440

local options = {
  nu = true,
  cursorline = true,
  relativenumber = true,

  errorbells = false,

  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,

  smartindent = true,

  wrap = false,

  scrolloff = 8,
  sidescrolloff = 8,
  signcolumn = "yes",

  cmdheight = 1,

  updatetime = 50,

  colorcolumn = "80",

  wildmenu = true,
  hlsearch = true
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
