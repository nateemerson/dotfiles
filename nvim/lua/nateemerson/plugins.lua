local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

-- Autocommand that syncs packer whenever you save this file.
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

require('packer').startup(function(use)
  local plenary = 'nvim-lua/plenary.nvim'
  use(plenary)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'

  use 'tiagovla/tokyodark.nvim'

  use 'princejoogie/tailwind-highlight.nvim'

  use {'tjdevries/colorbuddy.vim'}

  -- cmp plugins
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'

  -- snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  use { 'ThePrimeagen/harpoon', requires = plenary }
  use { 'nvim-lualine/lualine.nvim', requires = plenary }
  use { 'TimUntersberger/neogit', requires = plenary }
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = plenary }

  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      plen,
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    }
  }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
