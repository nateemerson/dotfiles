local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'

  use 'tiagovla/tokyodark.nvim'

  use 'princejoogie/tailwind-highlight.nvim'

  use {'tjdevries/colorbuddy.vim'}

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function () require('nvim-treesitter.install').update({ with_sync = true}) end,
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    }
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }


end)
