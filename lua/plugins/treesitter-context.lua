return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufReadPre",
  opts = function(_, opts)
    opts.max_lines = 0
  end,
}
