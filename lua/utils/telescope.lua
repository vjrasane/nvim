local M = {}

M.find_files_in = function(cwd)
  require("telescope.builtin").find_files({
    cwd = cwd,
    find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
    -- find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
  })
end

M.file_browser_in = function(cwd)
  require("telescope").extensions.file_browser.file_browser({
    cwd = cwd,
    -- path = "%:p:h=%:p:h",
    find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
  })
end

M.find_files = function()
  M.find_files_in(nil)
end

return M
