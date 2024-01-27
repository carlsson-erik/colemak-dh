return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      find_by_full_path_words = false,

      -- filtered_items = {
      --   visible = true,
      --   show_hidden_count = true,
      --   hide_dotfiles = false,
      --   hide_gitignored = false,
      --   hide_by_name = {
      --     -- '.git',
      --     -- '.DS_Store',
      --     -- 'thumbs.db',
      --   },
      --   never_show = {},
      -- },
    },

    window = {
      mappings = {
        ["/"] = "noop",
        ["g/"] = "fuzzy_finder",
      },
    },

    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
