return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    opts = function()
      -- local lualine_require = require("lualine_require")
      -- lualine_require.require = require

      local icons = require("config.icons")

      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          section_separators = "",
          component_separators = "|",
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "filename" },
          lualine_c = {},
          -- lualine_b = { "branch" },
          -- lualine_c = {
          --   require("utils.lualine").root_dir(),
          --
          --   { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          --   { require("utils.lualine").pretty_path() },
          --   {
          --     function()
          --       return require("nvim-navic").get_location()
          --     end,
          --     cond = function()
          --       return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
          --     end,
          --   },
          -- },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
          -- lualine_x = {
          -- stylua: ignore
          -- {
          --   function() return require("noice").api.status.command.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          --   color = require("utils").ui.fg("Statement"),
          -- },
          -- -- stylua: ignore
          -- {
          --   function() return require("noice").api.status.mode.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          --   color = require("utils").ui.fg("Constant"),
          -- },
          -- stylua: ignore
          -- {
          --   function() return "  " .. require("dap").status() end,
          --   cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
          --   color = require("utils").ui.fg("Debug"),
          -- },
          -- {
          --   "diagnostics",
          --   symbols = {
          --     error = icons.diagnostics.Error,
          --     warn = icons.diagnostics.Warn,
          --     info = icons.diagnostics.Info,
          --     hint = icons.diagnostics.Hint,
          --   },
          -- },
          -- {
          --   "diff",
          --   symbols = {
          --     added = icons.git.added,
          --     modified = icons.git.modified,
          --     removed = icons.git.removed,
          --   },
          --   source = function()
          --     local gitsigns = vim.b.gitsigns_status_dict
          --     if gitsigns then
          --       return {
          --         added = gitsigns.added,
          --         modified = gitsigns.changed,
          --         removed = gitsigns.removed,
          --       }
          --     end
          --   end,
          -- },
          -- },
          -- lualine_y = {
          --   -- { "progress", separator = " ", padding = { left = 1, right = 0 } },
          --   { "location", padding = { left = 0, right = 1 } },
          --   -- {
          --   --   require("lazy.status").updates,
          --   --   cond = require("lazy.status").has_updates,
          --   --   color = require("utils").ui.fg("Special"),
          --   -- },
          -- },
          -- lualine_z = {
          --   function()
          --     return "\u{e641} " .. os.date("%R")
          --   end,
          -- },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
