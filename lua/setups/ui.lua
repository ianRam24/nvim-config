-- Dashboard: snacks.nvim (alpha removed — conflicts with Snacks.dashboard)

require("lualine").setup({ options = { theme = "gruvbox-material" } })

require("noice").setup({
	notify = { timeout = 1000 },
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
})
vim.keymap.set("n", "<leader>nd", ":NoiceDismiss<CR>", { noremap = true, silent = true, desc = "Dismiss notifications" })

require("trouble").setup()
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP (Trouble)" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location list" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix list" })

require("todo-comments").setup()

local wk = require("which-key")
wk.setup({})
wk.add({
	{ "<leader>/", ":CommentToggle<CR>", desc = "Toggle comments" },
	{ "<leader>C", group = "[C]sharp" },
	{ "<leader>Ca", ":lua require('csharp').fix_all()<CR>", desc = "Fix all" },
	{ "<leader>Cr", ":lua require('csharp').run_project()<CR>", desc = "Run project" },
	{ "<leader>Cs", ":lua require('csharp').view_user_secrets()<CR>", desc = "View user secrets" },
	{ "<leader>Cu", ":lua require('csharp').fix_usings()<CR>", desc = "Fix usings" },
	{ "<leader>J", group = "[J]ava" },
	{ "<leader>Jb", ":JBuild<CR>", desc = "Build Java" },
	{ "<leader>Jr", ":JRun<CR>", desc = "Run Java" },
	{ "<leader>c", group = "[C]ode" },
	{ "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
	{ "<leader>cf", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, desc = "Format code" },
	{ "<leader>d", group = "[D]ebug" },
	{ "<leader>db", ":DebugToggleBreakpoint<CR>", desc = "Toggle breakpoint" },
	{ "<leader>dc", ":DebugStart<CR>", desc = "Continue debugging" },
	{ "<leader>G", group = "[G]it" },
	{ "<leader>GA", ":Git add .<CR>", desc = "Add all" },
	{ "<leader>Ga", ":Git add %<CR>", desc = "Add current file" },
	{ "<leader>GB", ":Git blame<CR>", desc = "Blame" },
	{ "<leader>GC", ":Git commit<CR>", desc = "Commit" },
	{ "<leader>GP", ":Git push<CR>", desc = "Push" },
	{ "<leader>gh", ":Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
	{ "<leader>t", group = "[T]est" },
	{ "<leader>tr", ":TestRun<CR>", desc = "Run tests" },
	{ "<leader>w", group = "[W]indow" },
	{ "<leader>ws", ":split<CR>", desc = "Horizontal split" },
	{ "<leader>wv", ":vsplit<CR>", desc = "Vertical split" },
	{ "<C-a>", ":lua require('csharp').fix_all()<CR>", desc = "Fix all" },
	{ "<C-r>", ":lua require('csharp').run_project()<CR>", desc = "Run project" },
	{ "<C-s>", ":lua require('csharp').view_user_secrets()<CR>", desc = "View user secrets" },
	{ "<C-u>", ":lua require('csharp').fix_usings()<CR>", desc = "Fix usings" },
})

require("inc_rename").setup()
require("render-markdown").setup({
	latex = { enabled = false },
	yaml = { enabled = false },
})
require("notebook").setup({
	insert_blank_line = true,
	show_index = true,
	show_cell_type = true,
	virtual_text_style = { fg = "lightblue", italic = true },
})
