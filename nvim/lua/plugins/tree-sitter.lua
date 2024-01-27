return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.filetype.add({ extension = { wgsl = "wgsl" } })

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.wgsl = {
      install_info = {
        url = "https://github.com/szebniok/tree-sitter-wgsl",
        files = { "src/parser.c" },
      },
    }

    -- add tsx and treesitter
    vim.list_extend(opts.ensure_installed, {
      "wgsl",
    })
  end,
}
