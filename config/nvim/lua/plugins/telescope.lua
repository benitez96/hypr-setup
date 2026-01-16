return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Buscar archivos" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Buscar texto (rg)" },
  },
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "🔍 ",
      selection_caret = " ",
      path_display = { "smart" },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
  end,
}
