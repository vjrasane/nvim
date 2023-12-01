local M = {}

function M.move_cursor(diagnostic)
  require("lspsaga.diagnostic"):move_cursor(diagnostic)
end

function M.goto_next(opts)
  require("lspsaga.diagnostic"):goto_next(opts)
end

function M.goto_prev(opts)
  require("lspsaga.diagnostic"):goto_prev(opts)
end

function M.list(opts)
  require("telescope.builtin").diagnostics(opts)
end

return M
