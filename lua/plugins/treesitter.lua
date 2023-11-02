return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPre",
  opts = {
    ensure_installed = {
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
      "astro",
    },
  },
}
