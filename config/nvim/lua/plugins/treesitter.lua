return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local ts = require("nvim-treesitter")

      ts.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      ts.install({
        "bash",
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "lua",
        "go",
      })

      -- 1) Highlighting: lo maneja Neovim, se activa por FileType
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "bash",
          "html",
          "css",
          "scss",
          "javascript",
          "typescript",
          "typescriptreact",
          "tsx",
          "json",
          "lua",
          "go",
        },
        callback = function()
          vim.treesitter.start()
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "lua",
          "go",
          "tsx",
          "typescript",
        },
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- 3) (Opcional) Folds con treesitter (Neovim)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "lua",
          "go",
          "javascript",
          "typescript",
          "typescriptreact",
          "tsx",
        },
        callback = function()
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end,
      })
    end,
  },
}
