local F = require("utils.fn")
local M = {}

function M.includes(value, table)
  return M.some(function(v)
    return v == value
  end, table)
end

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
function M.reduce(reducer, initial, table)
  local acc = initial
  for i, value in ipairs(table) do
    acc = reducer(acc, value, i, table)
  end
  return acc
end

function M.flatmap(mapper, table)
  return M.reduce(function(acc, curr)
    local mapped = mapper(curr)
    if type(mapped) == "table" then
      return M.concat(mapped, acc)
    end
    return M.append(mapped, acc)
  end, {}, table)
end

function M.copy(table)
  local result = {}
  for key, value in pairs(table) do
    result[key] = value
  end
  return result
end

function M.concat(second, first)
  local result = M.copy(first)
  for i = 1, #second do
    result[#result + 1] = second[i]
  end
  return result
end

function M.append(value, table)
  local result = M.copy(table)
  result[#result + 1] = value
  return result
end

function M.flatten(table)
  return M.flatmap(F.identity, table)
end

function M.reverse(table)
  local reversed = {}
  for i, value in ipairs(table) do
    reversed[#table - i + 1] = value
  end
  return reversed
end

return M
