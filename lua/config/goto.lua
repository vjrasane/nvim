M = {}

local telescope_provider = {
  definitions = function()
    require("telescope.builtin").lsp_definitions({ reuse_win = true })
  end,
  references = function()
    require("telescope.builtin").lsp_references({ reuse_win = true })
  end,
  implementations = function()
    require("telescope.builtin").lsp_implementations({ reuse_win = true })
  end,
  type_definitions = function()
    require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
  end,
}

local glance_provider = {
  definitions = function()
    vim.api.nvim_command("Glance definitions")
  end,
  references = function()
    vim.api.nvim_command("Glance references")
  end,
  implementations = function()
    vim.api.nvim_command("Glance implementations")
  end,
  type_definitions = function()
    vim.api.nvim_command("Glance type_definitions")
  end,
}

local saga_provider = {
  definitions = function()
    vim.api.nvim_command("Lspsaga peek_definition")
  end,
  references = function()
    vim.api.nvim_command("Lspsaga finder ref")
  end,
  implementations = function()
    vim.api.nvim_command("Lspsaga finder imp")
  end,
  type_definitions = function()
    vim.api.nvim_command("Lspsaga peek_type_definition")
  end,
}

M.providers = {
  telescope = telescope_provider,
  glance = glance_provider,
  saga = saga_provider,
}

M.provider = M.providers.saga

function M.definitions()
  M.provider.definitions()
end

function M.references()
  M.provider.references()
end

function M.implementations()
  M.provider.implementations()
end

function M.type_definitions()
  M.provider.type_definitions()
end

return M
