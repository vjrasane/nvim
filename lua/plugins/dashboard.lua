return {
  "nvimdev/dashboard-nvim",

  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      theme = "hyper",
      config = {
        week_header = {
          enable = true,
        },
        project = {
          enable = true,
          limit = 5,
          action = function(cwd)
            require("utils.telescope").find_files_in(cwd)
          end,
        },
        footer = { "", "[ @vjrasane ]" },
        shortcut = {
          { icon = "\u{eb29} ", desc = "Packages", group = "DashboardShortCutIcon", key = "l", action = "Lazy" },
          {
            icon = "\u{ea7b} ",
            desc = "Files",
            group = "DashboardShortCutIcon",
            action = function()
              require("telescope.builtin").find_files()
            end,
            key = "f",
          },
          {
            desc = " Home",
            group = "DashboardShortCutIcon",
            action = function()
              require("utils.telescope").file_browser_in("~/")
            end,
            key = "h",
          },
          {
            icon = "\u{e702} ",
            desc = "Repos",
            group = "DashboardShortCutIcon",
            action = function()
              require("utils.telescope").file_browser_in("~/repositories")
            end,
            key = "r",
          },
          {
            icon = "\u{eb51} ",
            desc = "Config",
            group = "DashboardShortCutIcon",
            action = function()
              require("utils.telescope").find_files_in("~/.config/nvim")
            end,
            key = "c",
          },
        },
      },
    })
  end,
  keys = {
    { "<leader>d", ":Dashboard<cr>", silent = true, desc = "Dashboard" },
  },
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "folke/which-key.nvim" },
  },
}
