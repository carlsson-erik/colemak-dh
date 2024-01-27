local function set_root_dir(...)
  return require("lspconfig.util").root_pattern(".git")(...)
end

local function ts_organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

-- local function show_signature_in_cmdline(_, result, _, _, bufnr)
--   if result == nil or vim.tbl_isempty(result.signatures) then
--     return
--   end
--   local signature = result.signatures[1]
--   local label = signature.label
--   -- You can format the label further if necessary
--   -- Display in the command line
--   vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { label })
-- end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/neodev.nvim" },
    opts = {
      diagnostics = {
        -- We use lsp-lines over this for diagnostics
        virtual_lines = false,

        -- signs = "×",
        float = {
          border = "rounded",
          format = function(diagnostic)
            return string.format(
              "%s (%s) [%s]",
              diagnostic.message,
              diagnostic.source,
              diagnostic.code or diagnostic.user_data.lsp.code
            )
          end,
        },
      },
      root_dir = set_root_dir,
      servers = {
        prismals = {},
        gopls = {
          format = false,
          analyses = {
            unusedparams = false,
          },
          staticcheck = true,
        },
        tsserver = {
          root_dir = set_root_dir,

          commands = {
            OrganizeImports = {
              ts_organize_imports,
              description = "Organize Imports",
            },
          },
          keys = {
            {
              "<leader>co",
              ts_organize_imports,
              desc = "Organize Imports",
            },
          },
        },
        eslint = {
          workingDirectories = { { mode = "auto" } },
          validate = "on", --
          -- root_dir = set_root_dir
        },
        tailwindcss = {
          root_dir = set_root_dir,
          filetypes = { "typescript.tsx" },
          settings = {
            tailwindCSS = {
              validate = true,
              lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning",
              },
              experimental = {
                classRegex = {
                  "tw`([^`]*)",
                  'tw="([^"]*)',
                  'tw={"([^"}]*)',
                  "tw\\.\\w+`([^`]*)",
                  "tw\\(.*?\\)`([^`]*)",
                  { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "classnames\\(([^)]*)\\)", "'([^']*)'" },
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                },
              },
            },
          },
        },
        ruff_lsp = {
          root_dir = set_root_dir,
          on_attach = function(client, _)
            client.server_capabilities.completionProvider = false
          end,
          init_options = {
            settings = {
              args = {},
            },
          },
        },
        pyright = {
          -- root_dir = set_root_dir,
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
              },
            },
          },
        },
      },
    },
    init = function()
      -- Add borders to hover window
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

      -- vim.lsp.handlers["textDocument/signatureHelp"] = show_signature_in_cmdline
    end,
  },
}
