return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_ok and cmp_nvim_lsp.default_capabilities() or {}
      )

      capabilities.textDocument.colorProvider = { dynamicRegistration = true }

      -- Configs (antes: lspconfig.<server>.setup)
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        cmd = { "gopls" },
      })

      vim.lsp.config("tailwindcss", {
        capabilities = capabilities,
      })

      vim.lsp.config("ts_ls", {
        cmd = { "typescript-language-server", "--stdio" },
        capabilities = capabilities,
      })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
      })

      vim.lsp.enable("gopls")
      vim.lsp.enable("tailwindcss")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("lua_ls")

      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      })

      -- Recomendación: mapear en LspAttach para que sea por-buffer y sólo cuando haya LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>gf", function() vim.lsp.buf.format({ async = true }) end, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        end,
      })
    end,
  }
}
