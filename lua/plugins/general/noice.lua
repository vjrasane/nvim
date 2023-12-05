return {
  "folke/noice.nvim",
  -- enabled = false,
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
            { find = "%d fewer lines" },
            { find = "%d more lines" },
            { find = "%d lines yanked" },
            { find = "%d lines moved" },
            { find = "%d lines indented" },
          },
        },
        view = "mini",
      },
    },
    views = {
      cmdline_popup = {
        border = {
          style = "none",
          padding = { 1, 1 },
        },
      },
      filter_options = {},
      win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
    },
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = false,
    },
  },
  -- config = function(_, opts)
  --   require("noice").setup(opts)
  --   local colors = require("catppuccin.palettes").get_palette()
  --   if not colors then
  --     return
  --   end
  --   local NoiceColor = {
  --     NoicePopupBorder = { fg = colors.mantle, bg = colors.mantle },
  --     NoiceCmdlinePopupBorder = { fg = colors.mantle, bg = colors.mantle },
  --   }
  --   for hl, col in pairs(NoiceColor) do
  --     vim.api.nvim_set_hl(0, hl, col)
  --   end
  -- end,
  -- stylua: ignore
  keys = {
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
}
