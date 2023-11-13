local lz = require("lazy.core.util")

local M = {}

function M.cwd()
  return M.realpath(vim.loop.cwd()) or ""
end

function M.realpath(path)
  if path == "" or path == nil then
    return nil
  end
  path = vim.loop.fs_realpath(path) or path
  return lz.norm(path)
end

return M
