return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("refactoring").setup()
		vim.api.nvim_set_keymap(
			"n",
			"<leader>rn",
			":lua require('refactoring').refactor('Rename')<CR>",
			{ noremap = true, silent = true }
		)
	end,
}
