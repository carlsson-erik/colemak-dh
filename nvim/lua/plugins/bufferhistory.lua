return {
  "bufferhistory",
  dev = true,
  opts = {},
  config = function(_, opts)
    require("custom.bufferhistory").setup(opts)
  end,
}
