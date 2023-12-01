return {
  "edluffy/specs.nvim",
  enabled = false,
  events = { "BufReadPre", "BufNewFile" },
  config = function()
    require("specs").setup({
      show_jumps = true,
      min_jump = 10,
      popup = {
        delay_ms = 0, -- delay before popup displays
        inc_ms = 10, -- time increments used for fade/resize effects
        blend = 100, -- starting blend, between 0-100 (fully transparent), see :h winblend
        width = 10,
        -- winhl = "PMenu",
        winhl = "DiagnosticError",
        fader = require("specs").linear_fader,
        resizer = require("specs").shrink_resizer,
      },
      ignore_filetypes = {},
      ignore_buftypes = {
        nofile = true,
      },
    })
  end,
}
