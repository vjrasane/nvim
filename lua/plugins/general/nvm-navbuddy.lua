return {
  "SmiteshP/nvim-navbuddy",
  event = "VeryLazy",
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = { lsp = { auto_attach = true } },
}
