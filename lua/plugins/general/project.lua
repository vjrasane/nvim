return {
  "ahmedkhalf/project.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  event = "VeryLazy",
  --   event = "VimEnter",
  config = function()
    require("project_nvim").setup({
      detection_methods = { "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".gitlab-ci.yml" },
      silent_chdir = true,
      show_hidden = true,
      ignore_lsp = { "tailwindcss", "jsonls", "emmet_ls" },
      exclude_dirs = { "~/.config/nvim/snippets" },
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
