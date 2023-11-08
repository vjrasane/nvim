return {
  "nvimdev/dashboard-nvim",
	priority = 100,
	 event = "VimEnter",
	opts = function ()
	-- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

return {
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
            icon = "\u{f12e2} ",
            desc = "Previous",
            group = "DashboardShortCutIcon",
            action = function()
              -- require("telescope.builtin").find_files()
              require("persistence").load({ last = true })
            end,
            key = "p",
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
    }
		end,
  -- config = function()
  --   require("dashboard").setup()
  -- end,
  keys = {
    { "<leader>D", ":Dashboard<cr>", silent = true, desc = "Dashboard" },
  },
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    -- { "folke/which-key.nvim" },
  },
}
