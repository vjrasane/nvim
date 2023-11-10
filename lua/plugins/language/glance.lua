return {
  "dnlhc/glance.nvim",
  event = "LspAttach",
  enabled = false,
  config = function()
    require("glance").setup({
      border = {
        -- enable = true,
        top_char = "―",
        bottom_char = "―",
      },
      -- mappings = {
      --   preview = {
      --     ["<leader>gL"] = actions.enter_win("list"), -- Focus list window
      --   },
      -- },
    })
  end,
  -- keys = {
  --   { "<leader>gL",function() require("glance").actions.enter_win("list") end, desc = "Focus List Window" }
  -- }
}
