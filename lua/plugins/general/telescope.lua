return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
          require("utils").on_load("telescope.nvim", function()
            require("telescope").load_extension("fzf")
          end)
        end,
      },
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "catppuccin/nvim" },
    },
    opts = function()
      local actions = require("telescope.actions")
      local open_with_trouble = function(...)
        return require("trouble.providers.telescope").open_with_trouble(...)
      end
      local open_selected_with_trouble = function(...)
        return require("trouble.providers.telescope").open_selected_with_trouble(...)
      end
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        require("utils.telescope").telescope(
          "find_files",
          { no_ignore = true, default_text = line }
        )()
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        require("utils.telescope").telescope("find_files", { hidden = true, default_text = line })()
      end
      local open_with_window_picker = function(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local path = require("plenary.path")

        actions.close(prompt_bufnr)
        local selected_entry = action_state.get_selected_entry()
        local _, entry_path = next(selected_entry)
        if not entry_path then
          return
        end
        local winid = require("window-picker").pick_window({
          filter_rules = {
            include_current_win = true,
          },
        })
        if not winid then
          return
        end
        local full_path = path:new(entry_path):absolute()
        vim.api.nvim_set_current_win(winid)
        vim.cmd("edit " .. vim.fn.fnameescape(full_path))
      end

      return {
        pickers = {
          -- git_files = {
          --   theme = "dropdown",
          --   hidden = true,
          -- },
          -- find_files = {
          --   theme = "dropdown",
          --   hidden = true,
          -- },
          -- oldfiles = {
          --   theme = "dropdown",
          --   hidden = true,
          -- },
          -- buffers = {
          --   theme = "dropdown",
          --   hidden = true,
          -- },
        },
        extensions = {
          -- file_browser = {
          --   theme = "dropdown",
          --   hidden = true,
          -- },
          -- projects = {
          --   theme = "dropdown",
          --   hidden = true,
          -- },
        },
        defaults = {
          hidden = true,
          sorting_strategy = "ascending", -- layout_strategy = "center",
          layout_strategy = "center",
          file_ignore_patterns = {
            "node_modules",
          },
          prompt_prefix = " ",
          selection_caret = "\u{e602} ",
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-c>"] = actions.close,
              -- ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = open_selected_with_trouble,
              ["<a-i>"] = find_files_no_ignore,
              ["<a-h>"] = find_files_with_hidden,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-x>"] = open_with_window_picker,
            },
            -- n = {
            --   ["q"] = actions.close,
            -- },
          },
        },
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      -- local colors = require("catppuccin.palettes").get_palette()
      -- local rasmus = require("rasmus.colors")
      local TelescopeColor = {
        -- TelescopeMatching = { fg = rasmus.cyan },
        -- TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
        --
        -- TelescopePromptPrefix = { bg = colors.surface0 },
        -- TelescopePromptNormal = { bg = colors.surface0 },
        -- TelescopeResultsNormal = { bg = colors.mantle },
        -- TelescopePreviewNormal = { bg = colors.mantle },
        -- TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
        -- TelescopeResultsBorder = { fg = "FloatBorder" },
        -- TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
        -- TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
        -- TelescopeResultsTitle = { fg = colors.mantle },
        -- TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
      }

      for hl, col in pairs(TelescopeColor) do
        vim.api.nvim_set_hl(0, hl, col)
      end
    end,
    keys = require("keymaps.telescope"),
    --   {
    --   {
    --     "<leader>,",
    --     "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
    --     desc = "Switch Buffer",
    --   },
    --   { "<leader>/", require("utils.telescope").telescope("live_grep", { cwd }), desc = "Grep (root dir)" },
    --   { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    --   { "<leader><space>", require("utils.telescope").telescope("files"), desc = "Find Files (root dir)" },
    --   -- find
    --   { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    --   { "<leader>fc", require("utils.telescope").config_files(), desc = "Find Config File" },
    --   { "<leader>fF", require("utils.telescope").telescope("files"), desc = "Find Files (root dir)" },
    --   { "<leader>ff", require("utils.telescope").telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
    --   { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    --   {
    --     "<leader>fR",
    --     require("utils.telescope").telescope("oldfiles", { cwd = vim.loop.cwd() }),
    --     desc = "Recent (root)",
    --   },
    --   -- git
    --   { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    --   { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
    --   -- search
    --   { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    --   { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    --   { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    --   { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    --   { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    --   { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    --   { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    --   { "<leader>sg", require("utils.telescope").telescope("live_grep"), desc = "Grep (root dir)" },
    --   { "<leader>sG", require("utils.telescope").telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    --   { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    --   { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    --   { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    --   { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    --   { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    --   { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    --   { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    --   {
    --     "<leader>sw",
    --     require("utils.telescope").telescope("grep_string", { word_match = "-w" }),
    --     desc = "Word (root dir)",
    --   },
    --   {
    --     "<leader>sW",
    --     require("utils.telescope").telescope("grep_string", { cwd = false, word_match = "-w" }),
    --     desc = "Word (cwd)",
    --   },
    --   { "<leader>sw", require("utils.telescope").telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
    --   {
    --     "<leader>sW",
    --     require("utils.telescope").telescope("grep_string", { cwd = false }),
    --     mode = "v",
    --     desc = "Selection (cwd)",
    --   },
    --   {
    --     "<leader>uC",
    --     require("utils.telescope").telescope("colorscheme", { enable_preview = true }),
    --     desc = "Colorscheme with preview",
    --   },
    --   {
    --     "<leader>ss",
    --     function()
    --       require("telescope.builtin").lsp_document_symbols({
    --         symbols = require("utils.telescope").kind_filter,
    --       })
    --     end,
    --     desc = "Goto Symbol",
    --   },
    --   {
    --     "<leader>sS",
    --     function()
    --       require("telescope.builtin").lsp_dynamic_workspace_symbols({
    --         symbols = require("utils.telescope").kind_filter,
    --       })
    --     end,
    --     desc = "Goto Symbol (Workspace)",
    --   },
    --   {
    --     "<leader>fl",
    --     function()
    --       require("utils.telescope").find_logs()
    --     end,
    --     desc = "Find Logs",
    --   },
    -- },
  },
}
