return {
  -- Colorscheme
  {
    "tiagovla/tokyodark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.tokyodark_transparent_background = true
      vim.g.tokyodark_enable_italic_comment = true
      vim.g.tokyodark_enable_italic = true
      vim.g.tokyodark_color_gamma = "1.0"
      vim.cmd("colorscheme tokyodark")
    end,
  },

  -- Color helper
  {
    "tjdevries/colorbuddy.vim",
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
  },

  -- Tailwind color highlighting
  {
    "princejoogie/tailwind-highlight.nvim",
    ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "astro", "vue" },
  },
}
