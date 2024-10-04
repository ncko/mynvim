return {
  {
    --
    'neovim/nvim-lspconfig',
    dependencies = {
      --
      { 'williamboman/mason.nvim', config = true }, -- must be loaded first
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      --
      --
      --
      { 'j-hui/fidget.nvim', opts = {} }, -- useful status updates. opts = {} automatically runs setup
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- LspAttach runs when a buffer is opened on a filetype associated with an LSP
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE:
          -- to def
          --
          -- In this
          -- for LSP
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame') -- variable under cursor
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction') -- suggested code changes

          -- toggle inlay hints in your code
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- add additional functionality to Neovim's LSP client using the nvim cmp plugin
      -- then broadcast all capabilities to the LSP servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- automatically install these servers with these configs
      -- available keys
      -- 	- cmd (table): override default command use to start the server
      -- 	- filetypes (table): override default list of fieltypes for the server
      -- 	- capabilities (table): override fields in capabilities (disable certain LSP features)
      -- 	- settings (table): override default settings passed when initiating the server
      -- `:help lspconfig-all` for list of all pre-configured LSPs
      local servers = {
        ruby_lsp = {},
        sorbet = {},
        pyright = {},
        phpactor = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('mason').setup() -- ensure servers above are installed

      -- add other tools for Mason to install
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- format lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- handles overriding only values explicitly passed
            -- by the server configuration above. Useful for disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
