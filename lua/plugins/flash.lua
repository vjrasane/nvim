return {
  "folke/flash.nvim",
  dependencies = {
    { "folke/which-key.nvim" },
  },
  init = function()
    require("which-key").register({
      j = {
        function()
          require("flash").jump()
        end,
        "Flash [J]ump",
      },
      t = {
        name = "treesitter",
        t = {
          function()
            require("flash").treesitter()
          end,
          "Flash [T]reesitter",
        },
        s = {
          function()
            require("flash").treesitter_search()
          end,
          "Flash Treesitter [S]earch",
        },
      },
    }, {
      mode = { "n", "v" },
      prefix = "<leader>",
    })
  end,
  keys = function()
    return {}
  end,
}
