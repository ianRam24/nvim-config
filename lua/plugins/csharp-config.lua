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
			"williamboman/mason.nvim", -- Requerido para instalar omnisharp automáticamente
			"mfussenegger/nvim-dap", -- Para depuración
			"Tastyep/structlog.nvim", -- Opcional, recomendado para debugging
		},
		config = function()
			require("mason").setup() -- Configura Mason antes de csharp.nvim para instalar omnisharp
			require("csharp").setup({
				lsp = {
					omnisharp = {
						enable = true,
						-- Si deseas especificar una ruta de Omnisharp manualmente, agrega el cmd_path aquí
						cmd_path = nil,
					},
					roslyn = {
						enable = false, -- Cambia esto a true si prefieres usar Roslyn en lugar de Omnisharp
						cmd_path = nil, -- Especifica la ruta a Roslyn si lo usas
					},
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
