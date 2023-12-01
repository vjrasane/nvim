local LazyUtil = require("lazy.core.util")

local M = {}
--
-- local deprecated = {
--   get_clients = "lsp",
--   on_attach = "lsp",
--   on_rename = "lsp",
--   root_patterns = { "root", "patterns" },
--   get_root = { "root", "get" },
--   float_term = { "terminal", "open" },
--   toggle_diagnostics = { "toggle", "diagnostics" },
--   toggle_number = { "toggle", "number" },
--   fg = "ui",
-- }

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    -- local dep = deprecated[k]
    -- if dep then
    --   local mod = type(dep) == "table" and dep[1] or dep
    --   local key = type(dep) == "table" and dep[2] or k
    --   M.deprecate([[require("utils").]] .. k, [[require("utils").]] .. mod .. "." .. key)
    --   ---@diagnostic disable-next-line: no-unknown
    --   t[mod] = require("utils." .. mod) -- load here to prevent loops
    --   return t[mod][key]
    -- end
    t[k] = require("utils." .. k)
    return t[k]
  end,
})

function M.is_wsl()
  return vim.fn.has("wsl") == 1
end
function M.is_win()
  return vim.loop.os_uname().sysname:find("Windows") ~= nil
end

function M.has(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

function M.on_load(name, fn)
  local Config = require("lazy.core.config")
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

return M
