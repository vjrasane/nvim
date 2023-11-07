M = {}

function M.next(opts)
  local trouble = require("trouble")
  if not trouble.is_open() then
    trouble.open()
  end
  trouble.next(opts)
end

function M.previous(opts)
  local trouble = require("trouble")
  if not trouble.is_open() then
    trouble.open()
  end
  trouble.previous(opts)
end

return M
