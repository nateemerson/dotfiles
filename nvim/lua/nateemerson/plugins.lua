local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  local plenary = 'nvim-lua/plenary.nvim'
  use(plenary)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'

  use 'tiagovla/tokyodark.nvim'

  use 'princejoogie/tailwind-highlight.nvim'

  use {'tjdevries/colorbuddy.vim'}

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function () require('nvim-treesitter.install').update({ with_sync = true}) end,
  }

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



end)
