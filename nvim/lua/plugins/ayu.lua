return {
  -- add onedark
  {
    "Shatur/neovim-ayu",
    config = function()
      require("ayu").setup({
        mirage = true,
      })
    end,
  },

  -- Configure LazyVim to load onedark
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu",
    },
  },
}
