return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
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
