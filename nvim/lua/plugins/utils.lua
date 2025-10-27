return {
  -- Core dependency used by multiple plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Auto close brackets
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
  },
}
