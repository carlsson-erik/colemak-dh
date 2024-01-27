local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      local luasnip = require("luasnip")
      -- local lspkind = require("lspkind")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        -- ["<tab>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if require("copilot.suggestion").is_visible() then
            print("1")
            require("copilot.suggestion").accept()
          -- elseif cmp.visible() then
          --   cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif has_words_before() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),

        ["<S-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          end
        end, {
          "i",
          "s",
        }),
      })

      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
}
