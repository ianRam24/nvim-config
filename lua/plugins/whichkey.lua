return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		local which_key = require("which-key")

		which_key.setup({})

		which_key.register({
			-- Comments Group
			["/"] = { ":CommentToggle<CR>", "Toggle Comments" }, -- Example command

			-- Java Group
			J = { name = "[J]ava" },
			["Jr"] = { ":JRun<CR>", "Run Java" },
			["Jb"] = { ":JBuild<CR>", "Build Java" },
			-- Code Group
			c = { name = "[C]ode" },
			["cf"] = { ":lua vim.lsp.buf.formatting()<CR>", "Format Code" },
			["ca"] = { ":lua vim.lsp.buf.code_action()<CR>", "Code Action" },
			-- Debug Group
			d = { name = "[D]ebug" },
			["db"] = { ":DebugToggleBreakpoint<CR>", "Toggle Breakpoint" },
			["dc"] = { ":DebugContinue<CR>", "Continue Debugging" },
			-- Explorer
			e = { ":Neotree filesystem reveal right toggle<CR>", "File Explorer" },

			-- Find Group
			f = { name = "[F]ind" },
			["ff"] = { ":Telescope find_files<CR>", "Find Files" },
			["fg"] = { ":Telescope live_grep<CR>", "Live Grep" },
			-- Git Group
			g = { name = "[G]it" },
			["gs"] = { ":Git<CR>", "Git Status" },
			["gp"] = { ":Git push<CR>", "Git Push" },
			-- Test Group
			t = { name = "[T]est" },
			["tr"] = { ":TestRun<CR>", "Run Tests" },
			-- Window Group
			w = { name = "[W]indow" },
			["ws"] = { ":split<CR>", "Horizontal Split" },
			["wv"] = { ":vsplit<CR>", "Vertical Split" },
			-- C# Group
			C = {
				name = "[C]sharp",
				s = { ":lua require('csharp').view_user_secrets()<CR>", "View User Secrets" },
				r = { ":lua require('csharp').run_project()<CR>", "Run Project" },
				u = { ":lua require('csharp').fix_usings()<CR>", "Fix Usings" },
				a = { ":lua require('csharp').fix_all()<CR>", "Fix All" },
			},
		}, { prefix = "<leader>" })

		which_key.register({
			["<C-s>"] = { ":lua require('csharp').view_user_secrets()<CR>", "View User Secrets" },
			["<C-r>"] = { ":lua require('csharp').run_project()<CR>", "Run Project" },
			["<C-u>"] = { ":lua require('csharp').fix_usings()<CR>", "Fix Usings" },
			["<C-a>"] = { ":lua require('csharp').fix_all()<CR>", "Fix All" },
		}, { prefix = "<C>" })
	end,
}
