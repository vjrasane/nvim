return {
  "folke/flash.nvim",
  enabled = false,
  event = { "BufReadPre", "BufNewFile" },
  vscode = true,
  opts = {},
  keys = {
    {
      "<leader>j",
      mode = { "n", "v", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash [J]ump",
    },
    -- { "<leader>tt", mode = { "n", "v", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash [T]reesitter" },
    {
      "<leader>st",
      mode = { "n", "v", "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "[T]reesitter Search",
    },
  },
}
