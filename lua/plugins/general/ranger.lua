return {
  "kelly-lin/ranger.nvim",
  config = function()
    require("ranger-nvim").setup({
      keybinds = {
        ["<C-v>"] = require("ranger-nvim").OPEN_MODE.vsplit,
        ["<C-s>"] = require("ranger-nvim").OPEN_MODE.split,
      },
      replace_netrw = false,
    })
  end,
  keys = {
    {
      "<leader>e",
      function()
        require("ranger-nvim").open(true)
      end,
      desc = "Explorer",
    },
  },
}
