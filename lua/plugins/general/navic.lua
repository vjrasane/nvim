return {
  "SmiteshP/nvim-navic",
  -- enabled = false,
  -- init = function()
  --   vim.g.navic_silence = true
  --   require("config.lsp").on_attach(function(client, buffer)
  --     if client.supports_method("textDocument/documentSymbol") then
  --       require("nvim-navic").attach(client, buffer)
  --     end
  --   end)
  -- end,
  -- opts = function()
  --   return {
  --     separator = " ",
  --     highlight = true,
  --     depth_limit = 5,
  --     icons = require("config.icons").kinds,
  --     lazy_update_context = true,
  --   }
  -- end,
}
