local T = require("utils.table")
local B = require("utils.buffer")

local M = {}

M.opts = {
  diagnostic = {
    priority = {},
    ignore_under_cursor = false,
  },
  handlers = {
    on_attach = function() end,
    goto = nil,
    goto_next = function() end,
    goto_prev = function() end
  },
}

local saga_provider = {
  move_cursor = function(diagnostic)
    require("lspsaga.diagnostic"):move_cursor(diagnostic)
  end,
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

function M.goto_prev(severity)
  if severity then
    return M.provider.goto_prev({ severity = severity })
  end
  local diagnostic = M.get_diagnostic(-1)
  if not diagnostic then
    return M.provider.goto_prev()
  end
  M.provider.move_cursor(diagnostic)
end

function M.goto_next(severity)
  if severity then
    return M.provider.goto_next({ severity = severity })
  end
  local diagnostic = M.get_diagnostic(function() end)
  if not diagnostic then
    return M.provider.goto_next()
  end
  M.provider.move_cursor(diagnostic)
end

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

function M.get_diagnostic(direction)
  local function get_diagnostic(severity)
    local accessor = direction < 0 and vim.diagnostic.get_prev or vim.diagnostic.get_next
    return accessor({ severity = severity })
  end

  local diagnostic = M.opts.diagnostic
  local priority = diagnostic.priority
  for _, group in ipairs(priority) do
    local ds = T.compact(T.map(get_diagnostic, group))
    local omitted = diagnostic.ignore_under_cursor and T.omit(B.is_diagnostic_under_cursor, ds) or ds
    local closest = M.get_closest(direction, omitted)

    if closest then
      return closest
    end
  end
  return nil
end

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts)
  require("utils.lsp").on_attach(M.opts.on_attach)
end

return M
