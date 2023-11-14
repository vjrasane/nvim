local M = {}

function M.keymaps(buf)
  vim.print("KEYMAPS", buf)
  vim.keymap.set("n", "<leader>dn", require("config.diagnostic").goto_next, { desc = "Next diagnostic", buffer = buf })
  vim.keymap.set(
    "n",
    "<leader>dp",
    require("config.diagnostic").goto_prev,
    { desc = "Previous diagnostic", buffer = buf }
  )
end

return M
