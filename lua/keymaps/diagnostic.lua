local D = require("utils.diagnostic")

local M = {}

function M.keymaps(viewer, buf, opts)
  local function goto_prev(severity)
    if severity then
      return viewer.goto_prev({ severity = severity })
    end
    local diagnostic = D.get_diagnostic(-1, opts)
    if not diagnostic then
      return viewer.goto_prev()
    end
    viewer.move_cursor(diagnostic)
  end

  local function goto_next(severity)
    if severity then
      return viewer.goto_next({ severity = severity })
    end
    local diagnostic = D.get_diagnostic(1, opts)
    if not diagnostic then
      return viewer.goto_next()
    end
    viewer.move_cursor(diagnostic)
  end

  vim.keymap.set("n", "<leader>dn", goto_next, { desc = "Next diagnostic", buffer = buf })
  vim.keymap.set("n", "<leader>dp", goto_prev, { desc = "Previous diagnostic", buffer = buf })
  vim.keymap.set("n", "<leader>dd", viewer.list, { desc = "Diagnostics list" })
end

return M
