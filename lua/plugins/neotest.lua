return {
  "nvim-neotest/neotest",
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python"),
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-python",
    "nvim-treesitter/nvim-treesitter",
  },
}
