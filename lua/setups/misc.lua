require("document-color").setup({ mode = "background" })

require("codesnap").setup({
	has_breadcrumbs = true,
	show_workspace = true,
	bg_color = "#535c68",
	bg_padding = 0,
})
vim.keymap.set("x", "<leader>cc", "<cmd>CodeSnap<cr>", { desc = "Code snapshot to clipboard" })
vim.keymap.set("x", "<leader>csnap", "<cmd>CodeSnapSave<cr>", { desc = "Save code snapshot" })
