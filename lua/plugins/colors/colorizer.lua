return {
  {
    "norcalli/nvim-colorizer.lua",
    -- event = { "BufReadPre", "BufNewFile" },
    ft = { "vim", "lua" },
    config = function()
      require("colorizer").setup({
        "vim",
        "lua",
      })
    end,
  },
}
