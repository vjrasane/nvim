local T = require("utils.table")
local B = require("utils.buffer")

local M = {}

function M.is_closer(direction, closest, current)
  local closest_pos = { closest.lnum + 1, closest.col }
  local current_pos = { current.lnum + 1, current.col }
  local closest_dist = B.get_cursor_distance(direction, closest_pos)
  local current_dist = B.get_cursor_distance(direction, current_pos)
  return B.distcomp(closest_dist, current_dist) > 0
end

function M.get_closest(direction, diagnostics)
  return T.compby(function(closest, current)
    return M.is_closer(direction, closest, current)
  end, diagnostics)
end

function M.get_diagnostic(direction, opts)
  opts = vim.tbl_deep_extend("force", {
    priority = {},
    ignore_under_cursor = false,
  }, opts)

  local function get_diagnostic(severity)
    local accessor = direction < 0 and vim.diagnostic.get_prev or vim.diagnostic.get_next
    return accessor({ severity = severity })
  end

  for _, group in ipairs(opts.priority) do
    local ds = T.compact(T.map(get_diagnostic, group))
    local omitted = opts.ignore_under_cursor and T.omit(B.is_diagnostic_under_cursor, ds) or ds
    local closest = M.get_closest(direction, omitted)

    if closest then
      return closest
    end
  end
  return nil
end

return M
