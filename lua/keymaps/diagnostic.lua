local M = {}

function M.keymaps(buf)
  vim.keymap.set("n", "<leader>dn", require("config.diagnostic").goto_next, { desc = "Next diagnostic", buffer = buf })
  vim.keymap.set(
    "n",
    "<leader>dp",
    require("config.diagnostic").goto_prev,
    { desc = "Previous diagnostic", buffer = buf }
  )
  vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics list" })
end

return M
