return {
  "SmiteshP/nvim-navbuddy",
  event = "LspAttach",
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = { lsp = { auto_attach = true } },
  keys = {
    {
      "<leader>cn",
      function()
        require("nvim-navbuddy").open()
      end,
      desc = "Navbuddy",
    },
  },
}
