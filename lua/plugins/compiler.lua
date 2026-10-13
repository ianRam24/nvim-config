return {
	{
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
		opts = {
			targets = {
				maven_compile = "make maven_compile",
				maven_build_and_run = "make maven_build_and_run",
				maven_run = "make maven_run",
			},
		},
		config = function()
			require("compiler").setup()
			-- Set key mappings for compiler.nvim
			vim.keymap.set(
				"n",
				"<leader>rc",
				":CompilerOpen<cr>",
				{ noremap = true, silent = true, description = "[R]un [C]ompiler" }
			)
			vim.keymap.set(
				"n",
				"<leader>sr",
				":CompilerStop<cr>",
				{ noremap = true, silent = true, description = "[S]top [R]un" }
			)
		end,
	},
	{
		"stevearc/overseer.nvim",
		commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		config = function()
			require("overseer").setup({
				task_list = {
					direction = "top",
					min_height = 25,
					max_height = 25,
					default_detail = 1,
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					layout_config = {
						prompt_position = "top",
						preview_cutoff = 120,
						width = 0.75,
						height = 0.75,
					},
					winblend = 0,
				},
			})
		end,
	},
}
