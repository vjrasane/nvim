M = {}

M.open_in = function(cwd)
  require("notify").notify(cwd, "info", nil)
  require("neo-tree.command").execute({
    action = "focus",
    source = "filesystem",
    position = "left",
    dir = cwd,
    reveal_file = cwd,
    -- reveal_file = cwd, -- path to file or folder to reveal
    -- reveal_force_cwd = true, -- change cwd without asking if needed
  })
end

return M
