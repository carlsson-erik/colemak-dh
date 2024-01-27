return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = true,
  opts = {
    settings = {
      save_on_toggle = true,
    },
  },
  keys = {
    {
      "<leader>a",
      function()
        require("harpoon"):list():append()
      end,
      desc = "Mark file with harpoon",
    },
    {
      "<C-S-P>",
      function()
        require("harpoon"):list():prev()
      end,
      desc = "Go to previous harpoon mark",
    },
    {
      "<C-S-N>",
      function()
        require("harpoon"):list():next()
      end,
      desc = "Go to next harpoon mark",
    },
    {
      "<C-h>",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Go to harpoon mark 1",
    },
    {
      "<C-j>",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Go to harpoon mark 2",
    },
    {
      "<C-k>",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Go to harpoon mark 3",
    },
    {
      "<C-l>",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Go to harpoon mark 4",
    },
    {
      "<C-e>",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Show harpoon marks",
    },
  },
}
