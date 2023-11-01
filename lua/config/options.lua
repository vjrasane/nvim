-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.winbar = "%=%m %f"
-- vim.opt.winbar = require("config.winbar").get_winbar()
-- vim.opt.authochdir = true
vim.opt.autochdir = true
vim.opt.conceallevel = 0
vim.o.laststatus = 2

vim.g.lualine_laststatus = 2

require("config.clipboard")
