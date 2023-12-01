return {
  "ahmedkhalf/project.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  event = "VeryLazy",
  --   event = "VimEnter",
  config = function()
    require("project_nvim").setup({
      detection_methods = { "pattern" },
      patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",
        ".gitlab-ci.yml",
      },
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
      "<leader>sp",
      function()
        require("telescope").extensions.projects.projects({

          attach_mappings = function(_, map)
            -- local open_project = function(prompt_bufnr)
            --   local selected_entry = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
            --   require("utils.log").info(selected_entry)
            --   require("telescope.actions").close(prompt_bufnr)
            -- end
            -- map("n", "<cr>", open_project)
            -- map("i", "<cr>", open_project)
            return true
          end,
        })
      end,
      desc = "Find Projects",
    },
  },
}
