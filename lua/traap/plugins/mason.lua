return {
  -- {{{ nvim-lspconfig

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },

    -- option
    opts = function()
      return {
        diagnostics = {
          severity_sort = true,
          underline = true,
          update_in_insert = false,
          virtual_text = { spacing = 4, prefix = '●' },
        },
        autoformat = false,
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },

        servers = {
          jsonls = {},
          lua_ls = {
            settings = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
              },
            },
          },
        },

        -- Additional setup placeholder.
        setup = {},
      }
    end,

    -- config
    config = function(_, opts)

      -- setup autoformat
      require('traap.servers.lsp.format').autoformat = opts.autoformat

      -- setup formatting and keymaps
      require('traap.servers.lsp.handlers').on_attach(function(client, buffer)
        require('traap.servers.lsp.format').on_attach(client, buffer)
        require('traap.servers.lsp.keymaps').on_attach(client, buffer)
      end)

      -- diagnostics
      local signs = require('traap.core.constants').diagnostic_signs
      for name, icon in pairs(signs) do
        name = 'DiagnosticSign' .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
      end
      vim.diagnostic.config(opts.diagnostics)

      -- setup servers
      local servers = opts.servers
      local capabilities = handlers.capabilities
      local lspconfig = require('lspconfig')

      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup['*'] then
          if opts.setup['*'](server, server_opts) then
            return
          end
        end
        lspconfig[server].setup(server_opts)
      end

      -- lspconfig rename fix: lua_ls
      local mappings = require('mason-lspconfig.mappings.server')
      if not mappings.lspconfig_to_package.lua_ls then
        mappings.lspconfig_to_package.lua_ls = 'lua-language-server'
        mappings.package_to_lspconfig['lua-language-server'] = 'lua_ls'
      end

      -- ensure_installed
      local mlsp = require('mason-lspconfig')
      local available = mlsp.get_available_servers()
      local ensure_installed = {} ---@type string[]

      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot
          -- be installed with mason-lspconfig
          if server_opts.mason == false or not
            vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      -- mason lsp setup
      mlsp.setup({ ensure_installed = ensure_installed })
      mlsp.setup_handlers({ setup })
    end,
  },

  -- ----------------------------------------------------------------------- }}}
  -- {{{ null-ls

  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPre',
    dependencies = { 'mason.nvim' },
    opts = function()
      local nls = require('null-ls')
      return {
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },

  -- ----------------------------------------------------------------------- }}}
  -- {{{ Mason

  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr> ' } },

    -- opts = function()
    -- 	local servers = {}
    -- 	for _, value in pairs(require('traap.core.constants').lsp_to_mason) do
    -- 		table.insert(servers, value.mason)
    -- 	end
    -- 	return { ensure_installed = servers }
    -- end,

    -- config = function(plugin, opts)
    -- 	require('traap.servers.lsp.handlers').setup()
    -- 	require('mason').setup(opts)
    -- 	local mr = require('mason-registry')
    -- 	for _, value in ipairs(opts.ensure_installed) do
    -- 		local p = mr.get_package(value)
    -- 		if not p:is_installed() then
    -- 			p:install()
    -- 		end
    -- 	end
    -- end,

    -- opts = {
    --   ensure_installed = {
    --     'stylua',
    --     'shellcheck',
    --     'shfmt',
    --     'flake8'
    --   },
    -- },

    opts = {
      ensure_installed = require('traap.core.constants').mason_ensure_installed
    },


    config = function(plugin, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      for _, value in ipairs(opts.ensure_installed) do
        local p = mr.get_package(value)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },

  -- ----------------------------------------------------------------------- }}}
  -- {{{ fidget.nvim

  { 'j-hui/fidget.nvim', event = 'VeryLazy', config = true },

  -- ----------------------------------------------------------------------- }}}
}
