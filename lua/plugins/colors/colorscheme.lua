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
      { "tjdevries/colorbuddy.nvim", dependencies = {
        "SmiteshP/nvim-navic",
      } },
    },
    config = function()
      require("neosolarized").setup({
        comment_italics = true,
        background_set = false,
      })
      vim.cmd([[colorscheme neosolarized]])
    end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    enabled = false,
    name = "macchiato",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
  {
    "EdenEast/nightfox.nvim",

    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = { dim_inactive = true },
      })
      vim.cmd([[colorscheme terafox]])
    end,
  },
  {
    "davidosomething/vim-colors-meh",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme meh]])
    end,
  },
  {
    "kvrohit/rasmus.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme rasmus]])
    end,
  },
  {
    "ramojus/mellifluous.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      require("mellifluous").setup({
        dim_inactive = true,
      })
      vim.cmd([[colorscheme mellifluous]])
    end,
  },
  {
    "Shatur/neovim-ayu",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      require("ayu").setup({
        mirage = false,
      })
      vim.cmd([[colorscheme ayu]])
    end,
  },
  {
    "kartikp10/noctis.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    dependencies = {
      "rktjmp/lush.nvim",
    },
    config = function()
      vim.cmd([[colorscheme noctis]])
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme rose-pine]])
    end,
  },
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme modus]])
    end,
  },
  {
    "cseelus/vim-colors-lucid",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme lucid]])
    end,
  },
  {
    "Alexis12119/nightly.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      require("nightly").setup({
        transparent = true,
        styles = {
          comments = { italic = true },
          functions = { italic = false },
          variables = { italic = false },
          keywords = { italic = false },
        },
        highlights = {},
      })
      vim.cmd([[colorscheme nightly]])
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    enabled = true,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = false,
        dimInactive = false,
        colors = {
          theme = {
            all = {

              ui = {
                float = {
                  bg = "none",
                },
                bg_gutter = "none",
                bg = "none",
                bg_dim = "none",
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            -- Floating
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            -- Telescope
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
            -- Completion
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
          }
        end,
      })
      vim.cmd([[colorscheme kanagawa-wave]])
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    enabled = false,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({})

      vim.cmd("colorscheme github_dark_default")
    end,
  },
  {
    "ribru17/bamboo.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("bamboo").setup({
        transparent = true,
        dim_inactive = true,
      })
      require("bamboo").load()
    end,
  },
}
