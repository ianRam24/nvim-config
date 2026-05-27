require("gitsigns").setup({})
vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "Git preview hunk" })

vim.keymap.set("n", "<leader>gg", "<cmd>tabnew | Git | only<cr>", { desc = "Fugitive full page" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git diff split" })
