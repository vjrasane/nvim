local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("config.options")
require("config.clipboard")
require("config.lazy")
-- must be after lazy
require("config.keymaps")
require("config.autocmds")

local severity = vim.diagnostic.severity

require("utils.lsp").on_attach(function(_, buf)
  local viewer = require("config.diagnostic.lspsaga")
  require("keymaps.diagnostic").keymaps(viewer, buf, {
    priority = {
      { severity.ERROR, severity.WARN },
      { severity.INFO, severity.HINT },
    },
  })
end)

require("global")
