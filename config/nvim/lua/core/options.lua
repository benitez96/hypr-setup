-- Leader key
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- General
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 3 -- Global statusline

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Undo
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- Misc
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.mouse = "a"
vim.opt.showmode = false

-- Diagnostics
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})
