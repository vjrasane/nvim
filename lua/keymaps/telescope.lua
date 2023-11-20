return {
  { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
  {
    "<leader>fF",
    function()
      require("telescope.builtin").find_files({ cwd = require("config.root").get_cwd_root() })
    end,
    desc = "Find Files (root dir)",
  },
  {
    "<leader>ff",
    function()
      require("telescope.builtin").find_files({ cwd = require("utils.path").cwd() })
    end,
    desc = "Find Files (cwd)",
  },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
  { "<leader>fc", require("utils.telescope").config_files(), desc = "Find Config File" },
  {
    "<leader>fl",
    function()
      require("utils.telescope").find_logs()
    end,
    desc = "Find Logs",
  },
  -- git
  { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
  { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
  --   -- search
  { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
  { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
  { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
  { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
  { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
  { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
  { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
  {
    "<leader>sg",
    require("utils.telescope").telescope("live_grep", { cwd = require("config.root").get_cwd_root }),
    desc = "Grep",
  },
  { "<leader>sG", require("utils.telescope").telescope("live_grep", { cwd = false }), desc = "Grep (root)" },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
  { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
  { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
  { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
  { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
  { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
  {
    "<leader>sw",
    require("utils.telescope").telescope("grep_string", { word_match = "-w" }),
    desc = "Word (root dir)",
  },
  {
    "<leader>sW",
    require("utils.telescope").telescope("grep_string", { cwd = false, word_match = "-w" }),
    desc = "Word (cwd)",
  },
  { "<leader>sw", require("utils.telescope").telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
  {
    "<leader>sW",
    require("utils.telescope").telescope("grep_string", { cwd = false }),
    mode = "v",
    desc = "Selection (cwd)",
  },
  {
    "<leader>uC",
    require("utils.telescope").telescope("colorscheme", { enable_preview = true }),
    desc = "Colorscheme with preview",
  },
  {
    "<leader>ss",
    function()
      require("telescope.builtin").lsp_document_symbols({
        symbols = require("utils.telescope").kind_filter,
      })
    end,
    desc = "Goto Symbol",
  },
  {
    "<leader>sS",
    function()
      require("telescope.builtin").lsp_dynamic_workspace_symbols({
        symbols = require("utils.telescope").kind_filter,
      })
    end,
    desc = "Goto Symbol (Workspace)",
  },
}
