return {
  "williamboman/mason.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  --  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  --  build = ":MasonUpdate",
  config = function()
    require("mason").setup({
      {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "stylua",
        "shfmt",
        "tsserver",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        --        "isort", -- python formatter
        -- "black", -- python formatter
        "eslint_d", -- js linter
      },
    })
  end,
}
