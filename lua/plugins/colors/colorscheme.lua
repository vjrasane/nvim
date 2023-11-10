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
    "Rigellute/rigel",
    -- dir = "~/repositories/rigel",
    -- "vjrasane/rigel",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme rigel]])
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      require("tokyonight").setup({
        style = "moon",
        -- transparent = true,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      require("nordic").load()
    end,
  },
  {
    "rmehri01/onenord.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme onenord]])
    end,
  },
  {

    "svrana/neosolarized.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    dependencies = {
      { "tjdevries/colorbuddy.nvim" },
    },
    config = function()
      require("neosolarized").setup({
        comment_italics = true,
        background_set = false,
      })
    end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
