return {
  "ThePrimeagen/git-worktree.nvim",
  keys = {
    {
      "<leader>gt",
      function()
        require("telescope").extensions.git_worktree.git_worktrees()
      end,
      desc = "Git Worktrees",
    },
  },
  config = function()
    require("telescope").load_extension("git_worktree")
  end,
}
