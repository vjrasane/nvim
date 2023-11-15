return {
  "nvim-lua/plenary.nvim",
  cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" },
  keys = {
    { "<leader>cT", "<cmd>PlenaryBustedFile %<cr>", desc = "Run current test file" },
  },
}
