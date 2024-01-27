return {
  "stevearc/dressing.nvim",
  event = "BufReadPost",
  lazy = true,
  opts = {
    input = {
      insert_only = false,
      start_in_insert = false,
    },
  },
  config = function(_, opts)
    require("dressing").setup(opts)
  end,
}
