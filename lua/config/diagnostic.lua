local T = require("utils.table")
local M = {}

M.opts = {
  diagnostic = {
    priority = {},
  },
  on_attach = function()
    vim.print("OLD")
  end,
}

local saga_provider = {
  goto_next = function(opts)
    require("lspsaga.diagnostic"):goto_next(opts)
  end,
  goto_prev = function(opts)
    require("lspsaga.diagnostic"):goto_prev(opts)
  end,
}

M.providers = {
  saga = saga_provider,
}

M.provider = M.providers.saga

function M.goto_next(severity)
  if not severity then
    severity = M.get_severity(vim.diagnostic.get_next)
  end
  print("NEXT", severity)
  M.provider.goto_next({ severity = severity })
end

function M.goto_prev(severity)
  if not severity then
    severity = M.get_severity(vim.diagnostic.get_prev)
  end
  M.provider.goto_prev({ severity = severity })
end

function f()
  local und = undefined
  local error = arg
  local unused = "ad"
end
function M.current_line()
  return unpack(vim.api.nvim_win_get_cursor(0))
end

function M.inrange(start, _end, value)
  return value <= _end and value >= start
end

function M.get_severity(direction)
  local priority = M.opts.diagnostic
  for _, group in ipairs(priority) do
    local diagnostic = direction({
      severity = group,
    })

    if diagnostic then
      return diagnostic.severity
    end
  end
  return nil
end

function M.get_highest_severity()
  local row, col = M.current_line()

  local function is_under_cursor(d)
    return M.inrange(d.lnum, d.end_lnum, row - 1) and M.inrange(d.col, d.end_col, col - 1)
  end

  local function get_severity(d)
    return d.severity
  end

  local diagnostics = T.omit(is_under_cursor, vim.diagnostic.get(0))
  local most_severe = T.minby(get_severity, diagnostics)
  if not most_severe then
    return nil
  end
  return most_severe.severity
end

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts)
  require("utils.lsp").on_attach(M.opts.on_attach)
end

return M
