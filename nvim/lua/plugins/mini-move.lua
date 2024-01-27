return {
  "echasnovski/mini.move",
  version = false,
  opts = {
    mappings = {
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      left = "<C-h>",
      down = "<C-j>",
      up = "<C-k>",
      right = "<C-l>",

      -- Move current line in Normal mode
      line_left = "<C-S-H>",
      line_down = "<C-S-J>",
      line_up = "<C-S-K>",
      line_right = "<C-S-L>",
    },
  },
  config = function(_, opts)
    require("mini.move").setup(opts)
  end,
}
