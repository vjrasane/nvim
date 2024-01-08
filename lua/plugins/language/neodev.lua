return {
  {
    "folke/neodev.nvim",
    ft = "lua",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
    },
    config = function()
      require("neodev").setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
      })
    end,
  },
}
