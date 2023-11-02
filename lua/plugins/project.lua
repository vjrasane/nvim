return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup({
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".gitlab-ci.yml" },
      silent_chdir = false,
      show_hidden = true,
    })
    require("telescope").load_extension("projects")
  end,

  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = {
    {
      "<leader>fp",
      function()
        require("telescope").extensions.projects.projects({})
      end,
      desc = "Find Projects",
    },
  },
}
