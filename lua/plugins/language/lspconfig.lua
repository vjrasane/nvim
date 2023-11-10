return {
  {
    "neovim/nvim-lspconfig",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = false,
      },
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {
        tsserver = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
      setup = {},
    },

    config = function(_, opts)
      local autoformat_group = vim.api.nvim_create_augroup("AutoFormat", { clear = true })
      local init_autoformat = function(client, buffer)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = autoformat_group, buffer = buffer })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = autoformat_group,
            buffer = buffer,
            callback = vim.lsp.buf.format,
          })
        end
      end

      require("utils.lsp").on_attach(function(client, buffer)
        require("config.lsp.keymaps").on_attach(client, buffer)
      end)

      local register_capability = vim.lsp.handlers["client/registerCapability"]
      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require("config.lsp.keymaps").on_attach(client, buffer)
        return ret
      end

      for name, icon in pairs(require("config.icons").diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      -- if opts.inlay_hints.enabled and inlay_hint then
      --   require("utils.lsp").on_attach(function(client, buffer)
      --     if client.supports_method("textDocument/inlayHint") then
      --       inlay_hint(buffer, true)
      --     end
      --   end)
      -- end

      local find_icon = function(diagnostic)
        local icons = require("config.icons").diagnostics
        for d, icon in pairs(icons) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
      end

      opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●" or find_icon
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities() or {},
        {}
      )

      local function on_attach(client, buffer)
        -- init_autoformat(client, buffer)
      end

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
          on_attach = on_attach,
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      local all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)

      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      require("mason-lspconfig").setup({ ensure_installed = ensure_installed, handlers = { setup } })
    end,
  },
}
