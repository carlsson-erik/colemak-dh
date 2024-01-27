return {
  "folke/zen-mode.nvim",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below

    window = {
      width = 140,
    },
  },
  keys = {
    {
      "<leader>wz",
      "<cmd>ZenMode<cr>",
      desc = "Zen mode",
    },
  },
}