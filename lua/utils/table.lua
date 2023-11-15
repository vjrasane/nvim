local M = {}

function M.find(cond, table)
  for _, val in pairs(table) do
    if cond(val) then
      return val
    end
  end
  return nil
end

function M.some(cond, table)
  for _, val in pairs(table) do
    if cond(val) then
      return true
    end
  end
  return false
end

function M.filter(cond, table)
  local filtered = {}
  for key, val in pairs(table) do
    if cond(val) then
      filtered[key] = val
    end
  end
  return filtered
end

function M.omit(cond, table)
  return M.filter(function(val)
    return not cond(val)
  end, table)
end

function M.compby(comp, table)
  local current = nil
  for _, val in pairs(table) do
    if current == nil or comp(current, val) then
      current = val
    end
  end
  return current
end

function M.maxby(acc, table)
  return M.compby(function(curr, val)
    return acc(curr) < acc(val)
  end, table)
end

function M.minby(acc, table)
  return M.compby(function(curr, val)
    return acc(curr) > acc(val)
  end, table)
end

function M.len(T)
  local count = 0
  for _ in pairs(T) do
    count = count + 1
  end
  return count
end
function M.map(mapper, table)
  local mapped = {}
  for key, value in pairs(table) do
    mapped[key] = mapper(value)
  end
  return mapped
end
function M.compact(table)
  return M.omit(function(val)
    return val == nil
  end, table)
end
return M
