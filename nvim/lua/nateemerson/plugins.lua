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
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use 'tiagovla/tokyodark.nvim'

  use 'princejoogie/tailwind-highlight.nvim'

  use {'tjdevries/colorbuddy.vim'}

  -- cmp plugins
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  use { 'ThePrimeagen/harpoon', requires = plenary }
  use { 'nvim-lualine/lualine.nvim', requires = plenary }
  use { 'TimUntersberger/neogit', requires = plenary }
  use { 'nvim-telescope/telescope.nvim', requires = plenary }
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1]])

  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      plenary,
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    }
  }
end)
