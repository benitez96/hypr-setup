vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = ";"

vim.opt.swapfile = false
--
-- Insesitive when closing
vim.cmd([[cnoreabbrev W! w!]])
vim.cmd([[cnoreabbrev Q! q!]])
vim.cmd([[cnoreabbrev Qall! qall!]])
vim.cmd([[cnoreabbrev Wq wq]])
vim.cmd([[cnoreabbrev Wa wa]])
vim.cmd([[cnoreabbrev wQ wq]])
vim.cmd([[cnoreabbrev WQ wq]])
vim.cmd([[cnoreabbrev W w]])
vim.cmd([[cnoreabbrev Q q]])
vim.cmd([[cnoreabbrev Qall qall]])

-- Split window
vim.keymap.set('n', '<leader>s', ':split<Return><C-w>w', { silent = true })
vim.keymap.set('n', '<leader>v', ':vsplit<Return><C-w>w', { silent = true })

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Move visual block
vim.cmd([[vnoremap J :m '>+1<CR>gv=gv]])
vim.cmd([[vnoremap K :m '<-2<CR>gv=gv]])

-- Vmap for maintain Visual Mode after shifting > and <
vim.cmd([[vmap < <gv]])
vim.cmd([[vmap > >gv]])

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.relativenumber = true
vim.wo.number = true
vim.opt.clipboard = "unnamedplus"
