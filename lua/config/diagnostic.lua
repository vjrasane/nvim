local T = require("utils.table")
local M = {}

local saga_provider = {
  goto_next = function(severity)
    require("lspsaga.diagnostic"):goto_next({ severity = severity })
  end,
  goto_prev = function(severity)
    require("lspsaga.diagnostic"):goto_prev({ severity = severity })
  end,
}

M.providers = {
  saga = saga_provider,
}

M.provider = M.providers.saga

function M.goto_next(severity)
  if not severity then
    severity = M.get_highest_severity()
  end
  M.provider.goto_next(severity)
end

function M.goto_prev(severity)
  if not severity then
    severity = M.get_highest_severity()
  end
  M.provider.goto_prev(severity)
end

function M.current_line()
  return unpack(vim.api.nvim_win_get_cursor(0))
end

function M.inrange(start, _end, value)
  return value <= _end and value >= start
end

function M.get_highest_severity()
  local row, col = M.current_line()

  local function is_under_cursor(d)
    return not M.inrange(d.lnum, d.end_lnum, row - 1) and not M.inrange(d.col, d.end_col, col - 1)
  end

  local function get_severity(d)
    return d.severity
  end

  local diagnostics = T.filter(is_under_cursor, vim.diagnostic.get(0))
  local most_severe = T.minby(get_severity, diagnostics)
  if not most_severe then
    return nil
  end
  return most_severe.severity
end

return M
