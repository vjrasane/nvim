local find_files_in = function(cwd)
  require("telescope.builtin").find_files({ cwd = cwd })
end
local file_browser_in = function(cwd)
  require("telescope").extensions.file_browser.file_browser({ cwd = cwd, path = "path=%:p:h=%:p:h<cr>" })
end
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
            file_browser_in(cwd)
          end,
        },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          {
            desc = " Home",
            group = "directories",
            action = function()
              find_files_in("~/")
            end,
            key = "h",
          },
          {
            icon = "\u{e702} ",
            desc = "Repos",
            group = "Number",
            action = function()
              file_browser_in("~/repositories")
            end,
            key = "r",
          },
          {
            desc = " dotfiles",
            group = "Number",
            action = function()
              find_files_in("~/.config/nvim")
            end,
            key = "d",
          },
        },
      },
    })
  end,
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "folke/which-key.nvim" },
  },
}
