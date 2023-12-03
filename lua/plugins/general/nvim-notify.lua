return {
  {
    "rcarriga/nvim-notify",
    dependencies = {
      { "catppuccin/nvim" },
    },
    opts = {
      stages = "fade",
      render = function(bufnr, notif, highlights)
        local namespace = require("notify.render.base").namespace()
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, notif.message)

        vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
          hl_group = highlights.icon,
          end_line = #notif.message - 1,
          end_col = #notif.message[#notif.message],
          priority = 50,
        })
      end,
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    config = function(_, opts)
      require("notify").setup(opts)
      local colors = require("catppuccin.palettes").get_palette()
      if not colors then
        return
      end
      local border = colors.mantle
      local background = colors.mantle
      local NotifyColor = {
        NotifyERRORBorder = { fg = border, bg = border },
        NotifyWARNBorder = { fg = border, bg = border },
        NotifyINFOBorder = { fg = border, bg = border },
        NotifyDEBUGBorder = { fg = border, bg = border },
        NotifyTRACEBorder = { fg = border, bg = border },
        NotifyERRORBody = { fg = background, bg = background },
        NotifyWARNBody = { fg = background, bg = background },
        NotifyINFOBody = { fg = background, bg = background },
        NotifyDEBUGBody = { fg = background, bg = background },
        NotifyTRACEBody = { fg = background, bg = background },
      }

      for hl, col in pairs(NotifyColor) do
        vim.api.nvim_set_hl(0, hl, col)
      end
    end,
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
  },
}