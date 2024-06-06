vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set shiftwidth=2")
vim.o.number = true
vim.o.relativenumber = true
vim.o.clipboard = "unnamedplus"

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.g.mapleader = " "
-- Configuración de mapeos en Lua
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-A-v>', ':vsplit<CR>')

vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts, {desc ="LSP Rename"})
