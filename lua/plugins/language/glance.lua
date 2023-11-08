return {
  "dnlhc/glance.nvim",
  event = "LspAttach",
  config = function()
    require("glance").setup({
      border = {
        enabled = true,
        top_char = "―",
        bottom_char = "―",
      },
      mappings = {
        preview = {
          ["<leader>gl"] = require("glance").actions.enter_win("list"), -- Focus list window
        },
      },
    })
  end,
}
