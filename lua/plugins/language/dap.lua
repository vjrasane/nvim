return {
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapToggleBreakpoint" },
    enabled = false,
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint", noremap = true },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
    end,
    keys = {
      {
        "<leader>dt",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle Debugger UI",
        noremap = true,
      },
      {
        "<leader>dr",
        function()
          require("dapui").open({ reset = true })
        end,
        desc = "Reset Debugger UI",
        noremap = true,
      },
    },
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    enabled = false,
    dependencies = {
      "mfussenegger/nvim-dap",
      { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    },
    init = function()
      require("utils").on_load("nvim-dap-ui", function()
        require("nvim-dap-virtual-text").setup()
      end)
    end,
  },
}
