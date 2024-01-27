return {
  "ggandor/leap.nvim",
  enabled = true,
  opts = {
    safe_labels = {},
    -- highlight_unlabeled_phase_one_targets = true,
  },
  config = function(_, opts)
    local leap = require("leap")
    for k, v in pairs(opts) do
      leap.opts[k] = v
    end
    leap.add_default_mappings(true)
    vim.keymap.del({ "x", "o" }, "x")
    vim.keymap.del({ "x", "o" }, "X")

    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
    vim.api.nvim_set_hl(0, "LeapMatch", {
      -- For light themes, set to 'black' or similar.
      fg = "white",
      bold = true,
      nocombine = true,
    })

    vim.api.nvim_set_hl(0, "LeapLabelPrimary", {
      fg = "red",
      bold = true,
      nocombine = true,
    })
    vim.api.nvim_set_hl(0, "LeapLabelSecondary", {
      fg = "blue",
      bold = true,
      nocombine = true,
    })
  end,
}
