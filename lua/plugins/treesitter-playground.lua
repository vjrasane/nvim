return {
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
      },
    },
    run = ":TSInstall query",
  },
}
