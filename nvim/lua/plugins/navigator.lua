return {
  "ray-x/navigator.lua",
  dependencies = {
    { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
    { "neovim/nvim-lspconfig" },
  },
  config = function()
    require("navigator").setup({
      -- Configuration here, or leave empty to use defaults
      transparency = 1,
    })
  end,
  keys = {
    { "<leader>wl", mode = { "n" }, false },
  },
}
