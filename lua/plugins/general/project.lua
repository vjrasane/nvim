return {
  "ahmedkhalf/project.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  event = "VeryLazy",
  --   event = "VimEnter",
  config = function()
    require("project_nvim").setup({
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".gitlab-ci.yml" },
      silent_chdir = false,
      show_hidden = true,
      ignore_lsp = { "tailwindcss", "jsonls" },
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
