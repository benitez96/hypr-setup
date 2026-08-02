return {
  -- nvim-dap - Debug Adapter Protocol
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- DAP UI setup
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.33 },
              { id = "breakpoints", size = 0.17 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 0.33,
            position = "right",
          },
          {
            elements = {
              { id = "repl", size = 0.45 },
              { id = "console", size = 0.55 },
            },
            size = 0.27,
            position = "bottom",
          },
        },
      })

      -- Virtual text for debugging
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        show_stop_reason = true,
      })

      -- DAP UI autocommands
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- DAP keymaps
      vim.keymap.set("n", "<leader>dB", function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Breakpoint (conditional)" })

      vim.keymap.set("n", "<leader>db", function()
        require("dap").toggle_breakpoint()
      end, { desc = "Toggle Breakpoint" })

      vim.keymap.set("n", "<leader>dc", function()
        require("dap").continue()
      end, { desc = "Continue/Start Debugging" })

      vim.keymap.set("n", "<leader>dC", function()
        require("dap").run_to_cursor()
      end, { desc = "Run to Cursor" })

      vim.keymap.set("n", "<leader>di", function()
        require("dap").step_into()
      end, { desc = "Step Into" })

      vim.keymap.set("n", "<leader>do", function()
        require("dap").step_over()
      end, { desc = "Step Over" })

      vim.keymap.set("n", "<leader>dO", function()
        require("dap").step_out()
      end, { desc = "Step Out" })

      vim.keymap.set("n", "<leader>dt", function()
        require("dap").terminate()
      end, { desc = "Terminate Debugging" })

      vim.keymap.set("n", "<leader>dr", function()
        require("dap").repl.toggle()
      end, { desc = "Toggle REPL" })

      vim.keymap.set("n", "<leader>dl", function()
        require("dap").run_last()
      end, { desc = "Run Last" })

      vim.keymap.set("n", "<leader>du", function()
        require("dapui").toggle()
      end, { desc = "Toggle DAP UI" })
    end,
  },

  -- Mason DAP adapters
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "nvim-dap", "williamboman/mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "python",
        "codelldb",
        "js",
      },
      automatic_installation = true,
    },
  },
}
