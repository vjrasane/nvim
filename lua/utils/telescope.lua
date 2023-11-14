local path = require("utils.path")
local M = {}
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = path.root() }, opts or {})
    if builtin == "files" then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    if opts.cwd and opts.cwd ~= vim.loop.cwd() then
      opts.attach_mappings = function(_, map)
        map("i", "<a-c>", function()
          local action_state = require("telescope.actions.state")
          local line = action_state.get_current_line()
          M.telescope(
            params.builtin,
            vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
          )()
        end)
        return true
      end
    end

    require("telescope.builtin")[builtin](opts)
  end
end

function M.config_files()
  return M.telescope("find_files", { cwd = vim.fn.stdpath("config") })
end

M.kind_filter = {
  "Class",
  "Constructor",
  "Enum",
  "Field",
  "Function",
  "Interface",
  "Method",
  "Module",
  "Namespace",
  "Package",
  "Property",
  "Struct",
  "Trait",
}

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
