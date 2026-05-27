require("nuget").setup()

require("csharp").setup({
	lsp = {
		omnisharp = { enable = false, cmd_path = nil },
		roslyn = { enable = false, cmd_path = nil },
	},
})

vim.keymap.set("n", "<leader>Cs", "<cmd>lua require('csharp').view_user_secrets()<CR>", { desc = "C# user secrets" })
vim.keymap.set("n", "<leader>Cr", "<cmd>lua require('csharp').run_project()<CR>", { desc = "C# run project" })
vim.keymap.set("n", "<leader>Cu", "<cmd>lua require('csharp').fix_usings()<CR>", { desc = "C# fix usings" })
vim.keymap.set("n", "<leader>Ca", "<cmd>lua require('csharp').fix_all()<CR>", { desc = "C# fix all" })
