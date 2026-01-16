return {
  { "terrortylor/nvim-comment" },
  { "mbbill/undotree" },
  { "tpope/vim-surround" },
  { "norcalli/nvim-colorizer.lua" },
  { "mg979/vim-visual-multi" },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {
      filetypes = {"html", "javascript", "javascriptreact", "typescriptreact", "astro"},
    },
  },
}
