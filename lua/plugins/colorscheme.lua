return {{

'navarasu/onedark.nvim',
lazy = false,
priority = 1000,
config = function () 
	vim.cmd([[colorscheme onedark]])
end,
enabled = false
}, 
{
    "bluz71/vim-nightfly-guicolors",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme nightfly]])
    end,
  },}
