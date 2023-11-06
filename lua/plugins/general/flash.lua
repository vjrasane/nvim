return {
  "folke/flash.nvim",
  vscode = true,
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>j", mode = { "n", "v", "x", "o" }, function() require("flash").jump() end, desc = "Flash [J]ump" },
    { "<leader>tt", mode = { "n", "v", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash [T]reesitter" },
    { "<leader>ts", mode = { "n", "v", "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter [S]earch" },
  },
}
