local T = require("utils.table")
local M = {}

M.opts = {
  diagnostic = {
    priority = {},
  },
  on_attach = function() end,
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
  -- if not severity then
  --   severity = M.get_severity(vim.diagnostic.get_next)
  -- end
  -- print("NEXT", severity)
  M.provider.goto_next({ severity = severity })
end

function M.goto_prev(severity)
  -- if not severity then
  --   severity = M.get_severity(vim.diagnostic.get_prev)
  -- end
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

function M.get_line_count()
  return vim.fn.line("$")
end

function M.get_line(lnum)
  return vim.fn.getline(lnum)
end

function M.get_line_length(lnum)
  return string.len(M.get_line(lnum))
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

function M.get_line_distance(direction, start, _end, line_count)
  local start_lnum, start_col = unpack(start)
  local end_lnum, end_col = unpack(_end)
  local ldiff = direction * (end_lnum - start_lnum)
  if ldiff == 0 then
    local cdiff = direction * (end_col - start_col)
    return cdiff > 0 and 0 or line_count
  end
  return ldiff > 0 and ldiff or line_count + ldiff
end

function M.get_distance(direction, start, _end, line_count, end_col_len)
  local ldist = M.get_line_distance(direction, start, _end, line_count)
  local _, start_col = unpack(start)
  local _, end_col = unpack(_end)
  if ldist == 0 then
    return { ldist, direction * (end_col - start_col) }
  end
  return { ldist, direction > 0 and end_col or (end_col_len - end_col) }
end

function M.get_sev(direction)
  local function get_diagnostic(severity)
    local accessor = direction < 0 and vim.diagnostic.get_prev or vim.diagnostic.get_next
    return accessor({ severity = severity })
  end
  local priority = M.opts.diagnostic
  for _, group in ipairs(priority) do
    local ds = T.compact(T.map(get_diagnostic, group))
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
