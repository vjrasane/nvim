return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    require("lspsaga").setup({
      ui = {
        -- border = "none",
        code_action = "\u{f0eb}",
      },
      beacon = {
        enable = false,
      },
      outline = {
        close_after_jump = false,
        layout = "float",
        keys = {
          toggle_or_jump = "<space>",
          jump = "<cr>",
        },
      },
    })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
}
