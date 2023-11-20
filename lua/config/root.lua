local P = require("utils.path")
local T = require("utils.table")
local M = {}

M.stack = {
  "/",
  "~",
  "~/repositories",
  { resolver = "git" },
}

M.resolvers = {}

function M.resolvers.path(path, spec)
  local specpath = P.realpath(spec.path)
  if path:find(specpath, 1, true) == 1 then
    return specpath
  end
  return nil
end

function M.resolvers.pattern(path, spec)
  local result = vim.fs.find(spec.patterns, { path = path, upward = true })
  local _, first = next(result)
  return first and vim.fs.dirname(first) or nil
end

function M.resolvers.git(path, spec)
  return M.resolvers.pattern(path, { patterns = { ".git" } })
end

function M.get_path_root(path)
  path = P.realpath(path)

  function parse_spec(spec)
    if type(spec) == "string" then
      if M.resolvers[spec] then
        return { resolver = "spec" }
      end
      return { resolver = "path", path = spec }
    end
    if type(spec) == "table" then
      if M.resolvers[spec.resolver] then
        return spec
      end
      return { resolver = "pattern", patterns = spec }
    end
    return nil
  end

  local stack = T.reverse(T.compact(T.map(parse_spec, M.stack)))
  for i, spec in ipairs(stack) do
    local result = M.resolvers[spec.resolver](path, spec)
    if result then
      if result ~= path or i >= #stack then
        return result
      end
    end
  end
  return nil
end

function M.get_buf_root(bufno)
  local path = vim.api.nvim_buf_get_name(bufno or 0)
  return M.get_path_root(path)
end

function M.get_cwd_root()
  local path = vim.loop.cwd()
  return M.get_path_root(path)
end

return M
