local T = require("utils.table")

local M = {}

function M.filter_windows(window_ids, filters)
  local function get_window_buffer_info(wininfo)
    return vim.fn.getbufinfo(wininfo.bufnr)
  end
  local wininfos = T.flatmap(vim.fn.getwininfo, window_ids)
  local bufinfos = T.flatmap(get_window_buffer_info, wininfos)
  require("utils.log").info("INFOS", infos)
  return window_ids
end

return M
