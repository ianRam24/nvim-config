return {
	"klen/nvim-test",
	config = function()
		require("nvim-test").setup()
		--	vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>")
		--   vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<cr>")
		--vim.keymap.set("n", "<leader>ts", "<cmd>TestSuite<cr>")
		--	vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>")
		--vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<cr>")
	end,
}
