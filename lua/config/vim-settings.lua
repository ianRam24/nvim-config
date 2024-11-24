vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move selected lines down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Move selected lines up

vim.keymap.set("n", "<C-j>", ":m .+1<CR>==") -- Move current line down
vim.keymap.set("n", "<C-h>", "<C-w>h") -- Move to the left window
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-A-v>", ":vsplit<CR>") -- Vertical split

vim.keymap.set("n", "<leader>vrn", function()
	vim.lsp.buf.rename()
end, opts, { desc = "LSP Rename" }) -- Rename symbol
