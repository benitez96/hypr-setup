return {
  -- Neodev - Lua development support for Neovim
  {
    "folke/neodev.nvim",
    lazy = true,
    opts = {},
  },

  -- Lualine - statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Oil.nvim - edit your filesystem like a buffer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", function() require("oil").open() end, desc = "Open oil file explorer" },
    },
    opts = {
      default_file_explorer = false, -- don't replace netrw
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == ".."
        end,
      },
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "n",
      },
      float = {
        padding = 2,
        max_width = 100,
        max_height = 30,
        border = "rounded",
        win_options = {
          winblend = 10,
        },
      },
      preview = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = 0.9,
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        update_on_cursor_moved = true,
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" } },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
    },
  },

  -- Mini.nvim - essential modules
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      -- Better surround
      require("mini.surround").setup({
        mappings = {
          add = "gsa",
          delete = "gsd",
          find = "gsf",
          find_left = "gsF",
          highlight = "gsh",
          replace = "gsr",
          update_n_lines = "gsn",
        },
      })

      -- Better pairs
      require("mini.pairs").setup()

      -- Indent scope (complements snacks.indent)
      require("mini.indentscope").setup({
        symbol = "│",
        options = { try_as_border = true },
      })

      -- Comment
      require("mini.comment").setup({
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring").calculate_commentstring()
              or vim.bo.commentstring
          end,
        },
      })
    end,
  },

  -- Which-key - keymap helper
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      icons = {
        mappings = true,
      },
    },
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
    },
  },

  -- nvim-highlight-colors - inline color highlighting
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = {
      enabled_named_colors = true,
      render = "background",
      enable_tailwind = true,
      enable_named_colors = true,
      virtual_symbol = "●",
      virtual_symbol_position = "after",
    },
  },
}
