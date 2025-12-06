return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		local wk = require("which-key")

		wk.setup({})

		wk.add({
			-- Leader mappings
			{ "<leader>/", ":CommentToggle<CR>", desc = "Toggle Comments" },

			-- C# group
			{ "<leader>C", group = "[C]sharp" },
			{ "<leader>Ca", ":lua require('csharp').fix_all()<CR>", desc = "Fix All" },
			{ "<leader>Cr", ":lua require('csharp').run_project()<CR>", desc = "Run Project" },
			{ "<leader>Cs", ":lua require('csharp').view_user_secrets()<CR>", desc = "View User Secrets" },
			{ "<leader>Cu", ":lua require('csharp').fix_usings()<CR>", desc = "Fix Usings" },

			-- Java group
			{ "<leader>J", group = "[J]ava" },
			{ "<leader>Jb", ":JBuild<CR>", desc = "Build Java" },
			{ "<leader>Jr", ":JRun<CR>", desc = "Run Java" },

			-- Code group
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
			{ "<leader>cf", ":lua vim.lsp.buf.formatting()<CR>", desc = "Format Code" },

			-- Debug group
			{ "<leader>d", group = "[D]ebug" },
			{ "<leader>db", ":DebugToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
			{ "<leader>dc", ":DebugContinue<CR>", desc = "Continue Debugging" },

			-- Git group
			{ "<leader>G", group = "[G]it" },
			{ "<leader>GA", ":Git add .<CR>", desc = "Add [A]ll" },
			{ "<leader>Ga", ":Git add %<CR>", desc = "Add Current File" },
			{ "<leader>GB", ":Git blame<CR>", desc = "[B]lame" },
			{ "<leader>GC", ":Git commit<CR>", desc = "[C]ommit" },
			{ "<leader>GP", ":Git push<CR>", desc = "[P]ush" },
			{ "<leader>Gh", ":Gitsigns preview_hunk<CR>", desc = "Preview [H]unk" },

			-- Test group
			{ "<leader>t", group = "[T]est" },
			{ "<leader>tr", ":TestRun<CR>", desc = "Run Tests" },

			-- Window group
			{ "<leader>w", group = "[W]indow" },
			{ "<leader>ws", ":split<CR>", desc = "Horizontal Split" },
			{ "<leader>wv", ":vsplit<CR>", desc = "Vertical Split" },

			-- Ctrl mappings
			{ "<C-a>", ":lua require('csharp').fix_all()<CR>", desc = "Fix All" },
			{ "<C-r>", ":lua require('csharp').run_project()<CR>", desc = "Run Project" },
			{ "<C-s>", ":lua require('csharp').view_user_secrets()<CR>", desc = "View User Secrets" },
			{ "<C-u>", ":lua require('csharp').fix_usings()<CR>", desc = "Fix Usings" },
		})
	end,
}
