return {
  {
    -- "vjrasane/nvim-window-picker",
    "s1n7ax/nvim-window-picker",
    -- enabled = false,
    version = false,
    config = function()
      require("window-picker").setup({
        show_prompt = false,
        hint = "floating-big-letter",
        -- filter_func = function(window_ids, filters)
        --   require("utils.log").info("LOGGING")
        --   require("config.window-picker").filter_windows(window_ids, filters)
        -- end,
        filter_rules = {
          autoselect_one = true,
          include_current_win = false,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix", "Trouble", "fidget", "noice" },

            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "nofile" },
          },
        },
      })
    end,
    keys = {
      {
        "<leader>wp",
        function()
          local picker = require("window-picker")
          local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end,
        { desc = "Pick a window" },
      },
      {
        "<leader>wx",
        function()
          local picker = require("window-picker")
          local window = picker.pick_window()
          local target_buffer = vim.fn.winbufnr(window)
          -- Set the target window to contain current buffer
          vim.api.nvim_win_set_buf(window, 0)
          -- Set current window to contain target buffer
          vim.api.nvim_win_set_buf(0, target_buffer)
        end,
        { desc = "Swap windows" },
      },
    },
  },
}
