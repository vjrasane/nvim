return {
  "chrisgrieser/nvim-spider",
  enabled = false,
  keys = {
    {
      "e",
      function()
        require("spider").motion("e")
      end,
      mode = { "n", "o", "x" },
    },
    {
      "w",
      function()
        require("spider").motion("w")
      end,
      mode = { "n", "o", "x" },
    },
    {
      "b",
      function()
        require("spider").motion("b")
      end,
      mode = { "n", "o", "x" },
    },
    {
      "ge",
      function()
        require("spider").motion("ge")
      end,
      mode = { "n", "o", "x" },
    },
  },
}
