return {
  {

    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      vim.cmd([[colorscheme onedark]])
    end,
  },
  {
    "bluz71/vim-nightfly-guicolors",
    lazy = false,
    enabled = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd.colorscheme("nightfly")
    end,
  },
  {
    -- 'Rigellute/rigel',
    -- dir = "~/repositories/rigel",
    "vjrasane/rigel",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme rigel]])
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        "vim";
        "lua";
      })
    end
  },
}