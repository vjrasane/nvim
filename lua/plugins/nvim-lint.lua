return {
  "mfussenegger/nvim-lint",
  enabled = false,
  event = "BufWritePost",
  opts = {
    linters = {
      eslint_d = {
        args = {
          "--no-warn-ignored",
          "--format",
          "json",
          "--stdin",
          "--stdin-filename",
          function()
            return vim.api.nvim_buf_get_name(0)
          end,
        },
      },
    },
    linters_by_ft = {
      -- lua = { "luacheck" },
      fish = { "fish" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      astro = { "eslint_d" },
      golang = { "golangci-lint" },
      pythin = { "pylint" },
    },
  },
  config = function(_, opts)
    require("lint").linters_by_ft = opts.linters_by_ft
    -- require("lint").linters.eslint_d = opts.linters.eslint_d

    local lint_group = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_group,
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
