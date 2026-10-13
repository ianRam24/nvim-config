return {
	{
		"d7omdev/nuget.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("nuget").setup()
		end,
	},
	{
		"iabdelkareem/csharp.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"mfussenegger/nvim-dap", -- Para depuración
			"Tastyep/structlog.nvim", -- Opcional, recomendado para debugging
		},
		config = function()
			require("mason").setup() -- Configura Mason antes de csharp.nvim para instalar omnisharp
			require("csharp").setup({
				lsp = {
					-- roslyn.nvim handles the C# LSP; keep csharp.nvim helpers only
					omnisharp = { enable = false, cmd_path = nil },
					roslyn = { enable = false, cmd_path = nil },
				},
			})

			-- Keymaps for csharp.nvim with <leader> + C activation
			vim.api.nvim_set_keymap(
				"n",
				"<leader>Cs", -- <leader> + C + s for viewing user secrets
				"<cmd>lua require('csharp').view_user_secrets()<CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>Cr", -- <leader> + C + r for running the project
				"<cmd>lua require('csharp').run_project()<CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>Cu", -- <leader> + C + u for fixing usings
				"<cmd>lua require('csharp').fix_usings()<CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>Ca", -- <leader> + C + a for fixing all issues
				"<cmd>lua require('csharp').fix_all()<CR>",
				{ noremap = true, silent = true }
			)
		end,
	},
}
