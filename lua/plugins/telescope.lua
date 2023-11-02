return {
  "nvim-telescope/telescope.nvim",
  opts = {
    pickers = {
      find_files = {
        hidden = true,
      },
    },
    defaults = {
      file_ignore_patterns = {
        "node_modules",
      },
    },
  },
  keys = {
    { "<leader><space>", false },
    {
      "<leader>ff",
      function()
        require("utils.telescope").find_files()
      end,
      desc = "Find Files (root dir)",
    },
    {
      "<leader>fF",
      function()
        require("utils.telescope").find_files_in(vim.loop.cwd())
      end,
      desc = "Find Files (cwd)",
    },
    -- add a keymap to browse plugin files
    -- {
    --   "<leader>fp",
    --   function()
    --     require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
    --   end,
    --   desc = "Find Plugin File",
    -- },
  },
}
