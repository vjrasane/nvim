vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("vjrasane.options")
require("vjrasane.clipboard")
require("config.lazy")
require("vjrasane.lsp")
require("vjrasane.harpoon")
require("vjrasane.undotree")
require("vjrasane.fugitive")
require("vjrasane.remap")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- document existing key chains


-- require("Comment").setup()
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
