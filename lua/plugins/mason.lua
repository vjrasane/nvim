return {
  "williamboman/mason.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  cmd = "Mason",
  build = ":MasonUpdate",
  keys = { { "<leader>cM", "<cmd>Mason<cr>", desc = "Mason" } },
  opts = {
    ensure_installed = {
      "tsserver",
      "html",
      "cssls",
      "tailwindcss",
      "lua_ls",
      "graphql",
      "emmet_ls",
      "prismals",
      "pyright",
      "js-debug-adapter",
      "prettier", -- prettier formatter
      "stylua", -- lua formatter
      "eslint_d", -- js linter
    },
  },
  config = function(_, opts)
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
      ensure_installed = opts.ensure_installed,
    })

    require("mason-tool-installer").setup({
      ensure_installed = opts.ensure_installed,
    })

    vim.cmd([[MasonToolsInstall]])
  end,
}
