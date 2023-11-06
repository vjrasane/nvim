return {
  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup({
        hint = "floating-big-letter",
        filter_rules = {
          autoselect_one = true,
          include_current_win = false,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix", "Trouble" },

            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal" },
          },
        },
      })
    end,
    keys = {
      {
        "<leader>wp",
        function()
          local picker = require("window-picker")
          local picked_window_id = picker.pick_window({
            hint = "floating-big-letter",
            include_current_win = true,
          }) or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end,
        { desc = "Pick a window" },
      },
      {
	"<leader>wx",
        function()
          local picker = require("window-picker")
          local window = picker.pick_window({
            hint = "floating-big-letter",
            include_current_win = false,
          })
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
