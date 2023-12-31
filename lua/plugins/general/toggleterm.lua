return {
  {
    "akinsho/toggleterm.nvim",
    -- event = "VeryLazy",
    enabled = false,
    opts = {
      on_open = function()
        vim.cmd.startinsert()
      end,
      direction = "float",
      float_opts = {
        -- border = "double",
      },
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.25
        end
      end,
    },
    keys = {
      {
        "<leader>ft",
        ":ToggleTerm<cr>",
        desc = "Toggle Terminal",
        silent = true,
        mode = { "n" },
      },
      -- {
      --   "<C-T>",
      --   "<C-\\><C-n>:ToggleTerm<cr>",
      --   desc = "Toggle Terminal",
      --   silent = true,
      --   mode = { "t" },
      -- },
    },
  },
}
