local actions = require("telescope.actions")

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "bottom",
          },
        },
        sorting_strategy = "ascending",
      },
      extensions = {
        file_browser = {
          mappings = {
            ["i"] = {
              ["<tab>"] = require("telescope.actions").select_default,
            },
          },
        },
        cmdline = {
          mappings = {
            run_selection = "<CR>",
            run_input = "<C-CR>",
          },
        },
        run_selection = "<C-CR>",
      },
    },
    keys = {
      { "<leader>:", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
    },
    dependencies = {
      "jonarrien/telescope-cmdline.nvim",
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("cmdline")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    keys = {
      {
        "<leader>.",
        "<cmd>Telescope file_browser path=%:p:h=%:p:h<cr>",
        desc = "Browse files",
      },
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
}
