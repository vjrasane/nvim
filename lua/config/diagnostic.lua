local M = {}

local saga_provider = {
  goto_next = function(severity)
    require("lspsaga.diagnostic"):goto_next({ severity = severity })
  end,
  goto_prev = function(severity)
    require("lspsaga.diagnostic"):goto_prev({ severity = severity })
  end,
}

M.providers = {
  saga = saga_provider,
}

M.provider = M.providers.saga

function M.goto_next(severity)
  M.provider.goto_next(severity)
end
function M.goto_prev(severity)
  M.provider.goto_prev(severity)
end

return M
