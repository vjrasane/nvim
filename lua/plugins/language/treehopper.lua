return {
  "mfussenegger/nvim-treehopper",
  enabled = false,
  -- event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "phaazon/hop.nvim", config = true },
  },
  config = function()
    require("tsht")
  end,
  keys = {
    {
      "<leader>cj",
      function()
        require("tsht").move()
      end,
    },
  },
}
