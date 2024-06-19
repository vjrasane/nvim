return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  lazy = true,
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format()
      end,
      mode = { "n", "v" },
      desc = "Format",
    },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black", "autopep8" },
        sh = { "shfmt" },
        javascript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        astro = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        golang = { "golines" },
      },
      format_on_save = {
        timeout_ms = 5000,
        lsp_fallback = true,
      },
    })
  end,
}
