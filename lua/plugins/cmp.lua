return {
  "hrsh7th/nvim-cmp",
  config = function(_, opts)
    local cmp = require("cmp")
    opts.window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    }
    require("cmp").setup(opts)
  end,
  -- config = function()
  --   require("tailwindcss-colorizer-cmp").setup({})
  -- end,
  -- init = function()
  --   require("cmp").config.formatting = {
  --     format = require("tailwindcss-colorizer-cmp").formatter,
  --   }
  -- end,
  -- dependencies = {
  --   { "roobert/tailwindcss-colorizer-cmp.nvim" },
  -- },
}
