local Util = require("utils")
local api = vim.api
local ms = require("vim.lsp.protocol").Methods
local a = require("plenary.async")
local M = {}
local util = require("vim.lsp.util")

function M.code_action(options, callback)
  require("utils.log").info("CALLED", options)
  options = options or {}
  if options.diagnostics or options.only then
    options = { options = options }
  end
  local context = options.context or {}
  if not context.triggerKind then
    context.triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked
  end
  if not context.diagnostics then
    local bufnr = api.nvim_get_current_buf()
    context.diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr)
  end
  local mode = api.nvim_get_mode().mode
  local bufnr = api.nvim_get_current_buf()
  local win = api.nvim_get_current_win()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = ms.textDocument_codeAction })
  local remaining = #clients
  if remaining == 0 then
    if next(vim.lsp.get_clients({ bufnr = bufnr })) then
      vim.notify(vim.lsp._unsupported_method(ms.textDocument_codeAction), vim.log.levels.WARN)
    end
    return
  end

  local results = {}

  local function on_result(err, result, ctx)
    results[ctx.client_id] = { error = err, result = result, ctx = ctx }
    remaining = remaining - 1
    if remaining == 0 then
      callback(results, options)
    end
  end

  for _, client in ipairs(clients) do
    local params
    if options.range then
      assert(type(options.range) == "table", "code_action range must be a table")
      local start = assert(options.range.start, "range must have a `start` property")
      local end_ = assert(options.range["end"], "range must have a `end` property")
      params = util.make_given_range_params(start, end_, bufnr, client.offset_encoding)
    elseif mode == "v" or mode == "V" then
      local range = vim.lsp.buf.range_from_selection(bufnr, mode)
      params =
        util.make_given_range_params(range.start, range["end"], bufnr, client.offset_encoding)
    else
      params = util.make_range_params(win, client.offset_encoding)
    end
    params.context = context
    client.request(ms.textDocument_codeAction, params, on_result, bufnr)
  end
end

function M.get_code_actions(options)
  a.run(function()
    local result = a.wrap(M.code_action, 2)(options)
    vim.notify(vim.inspect(result))
  end, function() end)
end
function M.get_clients(opts)
  local ret = {}
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ret = vim.lsp.get_active_clients(opts)
    if opts and opts.method then
      ret = vim.tbl_filter(function(client)
        return client.supports_method(opts.method, { bufnr = opts.bufnr })
      end, ret)
    end
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

function M.on_rename(from, to)
  local clients = M.get_clients()
  for _, client in ipairs(clients) do
    if client.supports_method("workspace/willRenameFiles") then
      local resp = client.request_sync("workspace/willRenameFiles", {
        files = {
          {
            oldUri = vim.uri_from_fname(from),
            newUri = vim.uri_from_fname(to),
          },
        },
      }, 1000, 0)
      if resp and resp.result ~= nil then
        vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
      end
    end
  end
end

function M.get_config(server)
  local configs = require("lspconfig.configs")
  return rawget(configs, server)
end

function M.disable(server, cond)
  local util = require("lspconfig.util")
  local def = M.get_config(server)
  ---@diagnostic disable-next-line: undefined-field
  def.document_config.on_new_config = util.add_hook_before(
    def.document_config.on_new_config,
    function(config, root_dir)
      if cond(root_dir, config) then
        config.enabled = false
      end
    end
  )
end

function M.formatter(opts)
  opts = opts or {}
  local filter = opts.filter or {}
  filter = type(filter) == "string" and { name = filter } or filter
  local ret = {
    name = "LSP",
    primary = true,
    priority = 1,
    format = function(buf)
      M.format(Util.merge(filter, { bufnr = buf }))
    end,
    sources = function(buf)
      local clients = M.get_clients(Util.merge(filter, { bufnr = buf }))
      local ret = vim.tbl_filter(function(client)
        return client.supports_method("textDocument/formatting")
          or client.supports_method("textDocument/rangeFormatting")
      end, clients)
      return vim.tbl_map(function(client)
        return client.name
      end, ret)
    end,
  }
  return Util.merge(ret, opts)
end

function M.format(opts)
  opts = vim.tbl_deep_extend(
    "force",
    {},
    opts or {},
    require("utils").opts("nvim-lspconfig").format or {}
  )
  local ok, conform = pcall(require, "conform")
  -- use conform for formatting with LSP when available,
  -- since it has better format diffing
  if ok then
    opts.formatters = {}
    opts.lsp_fallback = true
    conform.format(opts)
  else
    vim.lsp.buf.format(opts)
  end
end

return M
