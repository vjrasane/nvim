local N = require("utils.number")

local M = {}

function M.get_cursor_position()
  return vim.api.nvim_win_get_cursor(0)
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

function M.distcomp(first, second)
  local first_lnum, first_col = unpack(first)
  local second_lnum, second_col = unpack(second)
  if first_lnum == second_lnum then
    return N.normalize(first_col - second_col)
  end
  return N.normalize(first_lnum - second_lnum)
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
  return { ldist, direction < 0 and (end_col_len - end_col) or end_col }
end

function M.get_cursor_distance(direction, pos)
  local pos_lnum, _ = unpack(pos)
  local cursor = M.get_cursor_position()
  return M.get_distance(direction, cursor, pos, M.get_line_count(), M.get_line_length(pos_lnum))
end

function M.is_under_cursor(start, _end)
  local cursor_lnum, cursor_col = unpack(M.get_cursor_position())
  local start_lnum, start_col = unpack(start)
  local end_lnum, end_col = unpack(_end)
  return N.inrange(start_lnum, end_lnum, cursor_lnum) and N.inrange(start_col, end_col, cursor_col)
end

function M.is_diagnostic_under_cursor(d)
  return M.is_under_cursor({ d.lnum + 1, d.col }, { d.end_lnum + 1, d.end_col })
end

return M
