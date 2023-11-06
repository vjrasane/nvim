local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
	{ import =	"plugins.general" },
},{
--  spec = {
--		{ import= "plugins.global" },
-- { import = "plugins" },
-- { import = "plugins.lsp" },
 -- },
colorscheme = function()
    require("tokyonight").load()
  end,
  defaults = {
    lazy = true,
    version = "*",
  },
news = {
    -- When enabled, NEWS.md will be shown when changed.
    -- This only contains big new features and breaking changes.
    lazyvim = true,
    -- Same but for Neovim's news.txt
    neovim = false,
  },
install = { colorscheme = {"nightfly" } },
  checker = { enabled = true, notify = true }, -- automatically check for plugin updates
  change_detection = { notify = true },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
