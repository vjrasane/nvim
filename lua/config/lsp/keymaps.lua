local M = {}
-- vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>')
-- vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>')
-- vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>')
-- vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>')
M._keys = {
  { "<leader>cI", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
  { "<leader>gd", "<cmd>Glance definitions<cr>", desc = "Goto Definition"},
  { "<leader>gr", "<cmd>Glance references<cr>", desc = "Goto References"},
  { "<leader>gI", "<cmd>Glance implementations<cr>", desc = "Goto Implementation"},
  { "<leader>gY", "<cmd>Glance type_definitions<cr>", desc = "Goto T[y]pe Definition"},
  -- {
  --   "gd",
  --   function()
  --     require("telescope.builtin").lsp_definitions({ reuse_win = true })
  --   end,
  --   desc = "Goto Definition",
  --   has = "definition",
  -- },
  -- { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
  -- { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
  -- {
  --   "gI",
  --   function()
  --     require("telescope.builtin").lsp_implementations({ reuse_win = true })
  --   end,
  --   desc = "Goto Implementation",
  -- },
  -- {
  --   "gY",
  --   function()
  --     require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
  --   end,
  --   desc = "Goto [T]ype Definition",
  -- },
  { "K", vim.lsp.buf.hover, desc = "Hover" },
  { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
  { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
  { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
  {
    "<leader>cA",
    function()
      vim.lsp.buf.code_action({
        context = {
          only = {
            "source",
          },
          diagnostics = {},
        },
      })
    end,
    desc = "Source Action",
    has = "codeAction",
  },
  { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
  { "<leader>dn", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
  { "<leader>dp", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
  { "<leader>dd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics List" },
}

function M.has(buffer, method)
  method = method:find("/") and method or "textDocument/" .. method
  local clients = require("utils.lsp").get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

function M.resolve(buffer)
  local Keys = require("lazy.core.handler.keys")
  if not Keys.resolve then
    return {}
  end
  local opts = require("utils").opts("nvim-lspconfig") or {}
  local clients = require("utils.lsp").get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local servers = opts.servers or {}
    local maps = servers[client.name] and servers[client.name].keys or {}
    vim.list_extend(M._keys, maps)
  end
  return Keys.resolve(M._keys)
end

function M.on_attach(_, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    if not keys.has or M.has(buffer, keys.has) then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
