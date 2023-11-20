local UI = require("utils.ui")
local P = require("utils.path")

local M = {}

function M.cmp_source(name, icon)
  local started = false
  local function status()
    if not package.loaded["cmp"] then
      return
    end
    for _, s in ipairs(require("cmp").core.sources) do
      if s.name == name then
        if s.source:is_available() then
          started = true
        else
          return started and "error" or nil
        end
        if s.status == s.SourceStatus.FETCHING then
          return "pending"
        end
        return "ok"
      end
    end
  end

  local colors = {
    ok = UI.fg("Special"),
    error = UI.fg("DiagnosticError"),
    pending = UI.fg("DiagnosticWarn"),
  }

  return {
    function()
      return icon or require("config.icons").kinds[name:sub(1, 1):upper() .. name:sub(2)]
    end,
    cond = function()
      return status() ~= nil
    end,
    color = function()
      return colors[status()] or colors.ok
    end,
  }
end

function M.format(component, text, hl_group)
  component.hl_cache = component.hl_cache or {}
  local lualine_hl_group = component.hl_cache[hl_group]
  if not lualine_hl_group then
    local utils = require("lualine.utils.utils")
    lualine_hl_group = component:create_hl({ fg = utils.extract_highlight_colors(hl_group, "fg") }, "LV_" .. hl_group)
    component.hl_cache[hl_group] = lualine_hl_group
  end
  return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
end

function M.pretty_path()
  return function(self)
    local path = vim.fn.expand("%:p")
    local parts = P.split(P.pretty(path, P.cwd()))
    local modified_hl = "Constant"
    if vim.bo.modified then
      parts[#parts] = M.format(self, parts[#parts], modified_hl)
    end
    return P.join(parts)
  end
end

function M.root_dir()
  local icon = "󱉭"
  local color = UI.fg("Special")

  local function get()
    return vim.fs.basename(require("utils.path").cwd())
  end

  return {
    function()
      return (icon .. " ") .. get()
    end,
    cond = function()
      return type(get()) == "string"
    end,
    padding = { left = 1, right = 1 },
    color = color,
  }
end

return M
