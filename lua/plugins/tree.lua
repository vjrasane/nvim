return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        dotfiles = true,
      },
    },
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    opts = {
      window = {
        position = "float",
      },
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    },
  },
}
