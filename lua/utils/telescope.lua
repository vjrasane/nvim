local M = {}

M.find_files_in = function(cwd)
  require("telescope.builtin").find_files({ cwd = cwd })
end

M.file_browser_in = function(cwd)
  require("telescope").extensions.file_browser.file_browser({ cwd = cwd, path = "path=%:p:h=%:p:h<cr>" })
end
return M
