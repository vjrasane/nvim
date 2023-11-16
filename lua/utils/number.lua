local M = {}
function M.normalize(num)
  if num == 0 then
    return 0
  end
  return num > 0 and 1 or -1
end
function M.inrange(start, _end, value)
  return value <= _end and value >= start
end

return M
