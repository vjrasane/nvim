local D = require("utils.diagnostic")

local M = {}

function M.keymaps(buf, opts)
  local function goto_prev(severity)
    if severity then
      return vim.diagnostic.goto_prev({ severity = severity })
    end
    local diagnostic = D.get_diagnostic(-1, opts)
    if not diagnostic then
      return vim.diagnostic.goto_prev()
    end
    vim.diagnostic.goto_prev({ severity = diagnostic.severity })
  end
  local unused = "asd"
  local function goto_next(severity)
    if severity then
      return vim.diagnostic.goto_next({ severity = severity })
    end
    local diagnostic = D.get_diagnostic(1, opts)
    if not diagnostic then
      return vim.diagnostic.goto_next()
    end

    vim.diagnostic.goto_next({ severity = diagnostic.severity })
  end

  vim.keymap.set("n", "<leader>dn", goto_next, { desc = "Next diagnostic", buffer = buf })
  vim.keymap.set("n", "<leader>dp", goto_prev, { desc = "Previous diagnostic", buffer = buf })
  vim.keymap.set("n", "<leader>dd", function()
    require("telescope.builtin").diagnostics()
  end, { desc = "Diagnostics list" })
end

return M
