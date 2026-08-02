return {
  -- Mason - package manager for LSP servers, DAP, linters, formatters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Mason tool installer for LSP servers
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "jsonls",
        "yamlls",
        "bashls",
        "pyright",
        "html",
        "cssls",
        "tailwindcss",
        "eslint",
      },
      automatic_installation = true,
    },
  },

  -- nvim-lspconfig - LSP configs (Neovim 0.11+ uses vim.lsp.config)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("neodev").setup({})

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.colorProvider = true

      -- Common on_attach for all LSP servers
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
        nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        nmap("<leader>cf", vim.lsp.buf.format, "Format Document")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("gK", vim.lsp.buf.signature_help, "Signature Help")
      end

      -- Default config applied to all servers
      vim.lsp.config("*", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- Simple servers
      local servers = {
        jsonls = {},
        yamlls = {},
        bashls = {},
        html = {},
        cssls = {},
        tailwindcss = {},
        eslint = {},
        pyright = {},
      }

      for server, config in pairs(servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end

      -- TypeScript/JavaScript
      vim.lsp.config("ts_ls", {
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
        },
      })
      vim.lsp.enable("ts_ls")

      -- Lua
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim" },
              disable = { "missing-fields" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
            format = { enable = false },
          },
        },
      })
      vim.lsp.enable("lua_ls")
    end,
  },

  -- nvim-cmp - completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({ border = "rounded" }),
          documentation = cmp.config.window.bordered({ border = "rounded" }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 10 },
          { name = "luasnip", priority = 9 },
          { name = "buffer", priority = 5, keyword_length = 3 },
          { name = "path", priority = 4 },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
        experimental = {
          ghost_text = { hl_group = "CmpGhostText" },
        },
      })
    end,
  },
}
