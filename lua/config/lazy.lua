local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  { import = "plugins.general" },
  { import = "plugins.language" },
  { import = "plugins.colors" },
  { import = "plugins.git" },
}, {
  dev = {
    -- directory where you store your local plugin projects
    path = "~/plugins",
    fallback = false,
  },
  defaults = {
    lazy = true,
    version = "*",
  },
  install = { colorscheme = { "nightfly", "onedark" } },
  checker = { enabled = true, notify = true }, -- automatically check for plugin updates
  change_detection = { notify = true },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
