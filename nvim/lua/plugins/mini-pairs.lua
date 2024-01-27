return {
  "echasnovski/mini.pairs",
  opts = {
    mappings = {
      ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\][^%([{]" },
      ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\][^%([{]" },
      ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\][^%([{]" },
    },
  },
}
