return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
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
  },
  {
    "easymotion/vim-easymotion",
    event = "VeryLazy",
    keys = {
      {
        "<leader>h",
        "<Plug>(easymotion-bd-w)",
        desc = "Easymotion",
      },
    },
    enabled = false,
  },
  {
    "smoka7/hop.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader><space>",
        function()
          require("hop").hint_char1({})
        end,
        desc = "Hop",
      },
    },
  },
}
