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
  -- neovim "core" stuff
  local plenary = 'nvim-lua/plenary.nvim'
  use(plenary)
  use 'wbthomason/packer.nvim'
  use 'windwp/nvim-autopairs'

  -- Colors and UI
  use 'tiagovla/tokyodark.nvim'
  use 'tjdevries/colorbuddy.vim'
  use { 'ThePrimeagen/harpoon', requires = plenary }
  use { 'nvim-lualine/lualine.nvim', requires = plenary }
  use { 'TimUntersberger/neogit', requires = plenary }
  use { 'nvim-telescope/telescope.nvim', requires = plenary }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    }
  }
  -- LSP Zero
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
    }
  }
  -- CMP
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lua'

  -- LSP & Treesitter
  use 'nvimtools/none-ls.nvim'
  use('MunifTanjim/prettier.nvim')
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- snippets
  use 'rafamadriz/friendly-snippets'


  -- webdev
  use 'princejoogie/tailwind-highlight.nvim'
end)
