local M = {}
M._keys = {
  { "<leader>cI", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
  {
    "<leader>gd",
    function()
      require("config.goto").definitions()
    end,
    desc = "Goto Definition",
  },
  {
    "<leader>gr",
    function()
      require("config.goto").references()
    end,
    desc = "Goto References",
  },
  {
    "<leader>gI",
    function()
      require("config.goto").implementations()
    end,
    desc = "Goto Implementation",
  },
  {
    "<leader>gY",
    function()
      require("config.goto").type_definitions()
    end,
    desc = "Goto T[y]pe Definition",
  },
  { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover" },
  -- { "K", vim.lsp.buf.hover, desc = "Hover" },
  -- { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
  -- { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
  -- { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
  {
    "<leader>ca",
    vim.lsp.buf.code_action,
    desc = "Code Action",
    mode = { "n", "v" },
    has = "codeAction",
  },
  -- {
  --   "<leader>ca",
  --   function()
  --     vim.api.nvim_command("Lspsaga code_action")
  --   end,
  --   desc = "Code Action",
  --   mode = { "n", "v" },
  --   has = "codeAction",
  -- },
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
  {
    "<leader>co",
    "<cmd>Lspsaga outline<cr>",
    desc = "Outline",
  },
  {
    "<leader>cn",
    function()
      require("nvim-navbuddy").open()
    end,
    desc = "Navigate",
  },
  { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
  -- { "<leader>dn", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
  -- { "<leader>dp", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
  -- { "<leader>dd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics List" },
  -- { "<leader>dn", require("config.diagnostic").goto_next, desc = "Next Diagnostic" },
  -- { "<leader>dp", require("config.diagnostic").goto_prev, desc = "Previous Diagnostic" },
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
