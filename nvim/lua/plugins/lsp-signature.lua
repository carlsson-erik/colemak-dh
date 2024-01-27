return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  config = function(_, opts)
    require("lsp_signature").setup(opts)

    vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { underline = true, bold = true })
  end,
}
