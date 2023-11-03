return {
  {
    "akinsho/toggleterm.nvim",
    -- event = "VeryLazy",
    opts = {
      on_open = function()
        vim.cmd.startinsert()
      end,
      direction = "float",
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
        "<C-t>",
        ":ToggleTerm<cr>",
        desc = "Toggle Terminal",
        silent = true,
        mode = { "n" },
      },
      {
        "<C-t>",
        "<C-\\><C-n>:ToggleTerm<cr>",
        desc = "Toggle Terminal",
        silent = true,
        mode = { "t" },
      },
    },
  },
}
