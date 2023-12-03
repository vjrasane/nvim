return {
  { "<leader>b", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
  {
    "<leader>f",
    function()
      require("telescope.builtin").find_files({ cwd = require("utils.path").cwd() })
    end,
    desc = "Find Files (cwd)",
  },
  {
    "<leader>F",
    function()
      require("telescope.builtin").find_files({ cwd = require("config.root").get_cwd_root() })
    end,
    desc = "Find Files (root dir)",
  },
  { "<leader>r", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
  { "<leader>sc", require("utils.telescope").config_files(), desc = "Find Config File" },
  {
    "<leader>sL",
    function()
      require("utils.telescope").find_logs()
    end,
    desc = "Find Logs",
  },
  { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
  { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
  { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
  {
    "<leader>sg",
    require("utils.telescope").telescope("live_grep", { cwd = vim.loop.cwd }),
    desc = "Grep",
  },
  {
    "<leader>sG",
    require("utils.telescope").telescope(
      "live_grep",
      { cwd = require("config.root").get_cwd_root }
    ),
    desc = "Grep (root)",
  },
  { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
  { "<leader>s:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
  { "<leader>sA", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
  { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
  { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
  { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
  { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
  { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
  { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
  {
    "<leader>sw",
    require("utils.telescope").telescope(
      "grep_string",
      { cwd = require("config.root").get_cwd_root, word_match = "-w" }
    ),
    desc = "Word (root dir)",
  },
  {
    "<leader>sW",
    require("utils.telescope").telescope("grep_string", { word_match = "-w" }),
    desc = "Word (cwd)",
  },
  {
    "<leader>sw",
    require("utils.telescope").telescope("grep_string", { cwd = false }),
    mode = "v",
    desc = "Selection (cwd)",
  },
  {
    "<leader>sW",
    require("utils.telescope").telescope(
      "grep_string",
      { cwd = require("config.root").get_cwd_root }
    ),
    mode = "v",
    desc = "Selection (root dir)",
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
  { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
  { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
}
