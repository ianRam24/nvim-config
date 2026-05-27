require("cinnamon").setup({
	keymaps = { extra = true },
	options = {
		override_keymaps = true,
		max_delta = { time = 500, line = -1 },
	},
})

require("code_runner").setup({
	filetype = {
		java = { "cd $dir &&", " $fileName &&", "java $fileNameWithoutExt" },
		python = "python3 -u",
		typescript = "deno run",
		rust = { "cd $dir &&", "rustc $fileName &&", "$dir/$fileNameWithoutExt" },
		c = function()
			local c_base = {
				"cd $dir &&",
				"gcc $fileName -o",
				"/tmp/$fileNameWithoutExt",
			}
			local c_exec = { "&& /tmp/$fileNameWithoutExt &&", "rm /tmp/$fileNameWithoutExt" }
			vim.ui.input({ prompt = "Add more args:" }, function(input)
				c_base[4] = input
				require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
			end)
		end,
		springboot = { "cd $dir &&", "mvn spring-boot:run" },
		javascript = "node $fileName",
	},
	mode = "float",
	float = {
		border = "rounded",
		width = 80,
		height = 30,
		winblend = 3,
		anchor = "NW",
		relative = "editor",
		row = math.floor((vim.o.lines - 30) / 2),
		col = math.floor((vim.o.columns - 80) / 2),
	},
})
vim.keymap.set("n", "<C-r>", ":RunCode<CR>", { noremap = true, silent = false, desc = "Run code" })

require("overseer").setup({
	task_list = {
		direction = "top",
		min_height = 25,
		max_height = 25,
		default_detail = 1,
	},
})
require("compiler").setup({
	targets = {
		maven_compile = "make maven_compile",
		maven_build_and_run = "make maven_build_and_run",
		maven_run = "make maven_run",
	},
})
require("telescope").setup({
	defaults = {
		layout_config = { prompt_position = "top", preview_cutoff = 120, width = 0.75, height = 0.75 },
		winblend = 0,
	},
})
vim.keymap.set("n", "<leader>rc", ":CompilerOpen<cr>", { desc = "Open compiler" })
vim.keymap.set("n", "<leader>sr", ":CompilerStop<cr>", { desc = "Stop compiler" })

-- Database
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_force_echo_notification = 1
vim.keymap.set("n", "<C-d>", ":tab DBUI<cr>", { desc = "Open DBUI" })
vim.keymap.set("n", "<C-q>", ":tabclose<cr>", { desc = "Close tab" })

-- Oil
require("oil").setup({
	default_file_explorer = false,
	use_devicons = true,
	view_options = { show_hidden = true },
	keymaps = {
		["<M-h>"] = "actions.select_split",
		q = "actions.close",
	},
})
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>-", function() require("oil").toggle_float() end, { desc = "Oil float" })

-- Terminal
require("toggleterm").setup({
	size = 15,
	open_mapping = [[<c-\>]],
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "rounded",
		width = math.floor(vim.o.columns * 0.75),
		height = math.floor(vim.o.lines * 0.6),
		winblend = 10,
		title = "Popup Terminal",
		title_pos = "center",
	},
})
local Terminal = require("toggleterm.terminal").Terminal
local popup = Terminal:new({
	direction = "float",
	float_opts = { border = "rounded", winblend = 10, title = "Popup Terminal", title_pos = "center" },
})
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Terminal bottom" })
vim.keymap.set("n", "<leader>tp", function() popup:toggle() end, { desc = "Popup terminal" })
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.ruler = false
		vim.opt_local.laststatus = 0
	end,
})

-- Neotest
local neotest = require("neotest")
neotest.setup({
	adapters = {
		require("neotest-java"),
		require("neotest-jest")({
			jestCommand = "pnpm test --",
			jestConfigFile = "jest.config.js",
			env = { CI = true },
			cwd = function() return vim.fn.getcwd() end,
		}),
	},
	summary = { enabled = true, expand_errors = true, follow = true },
})
vim.keymap.set("n", "<leader>tr", function()
	neotest.run.run()
	neotest.summary.open()
end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>ta", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run all tests" })
vim.keymap.set("n", "<leader>ts", function() neotest.run.stop() end, { desc = "Stop tests" })
vim.keymap.set("n", "<leader>to", function() neotest.output.open() end, { desc = "Test output" })
vim.keymap.set("n", "<leader>tO", function() neotest.output.open({ enter = true }) end, { desc = "Test output enter" })
vim.keymap.set("n", "<leader>ti", function() neotest.summary.toggle() end, { desc = "Test summary" })
vim.keymap.set("n", "<leader>tf", function()
	neotest.run.run(vim.fn.expand("%"))
	neotest.summary.open()
end, { desc = "Run file tests" })
vim.keymap.set("n", "<leader>tn", function()
	neotest.run.run()
	neotest.summary.open()
end, { desc = "Run test" })
vim.keymap.set("n", "[n", function() neotest.jump.prev({ status = "failed" }) end, { desc = "Previous failed test" })
vim.keymap.set("n", "]n", function() neotest.jump.next({ status = "failed" }) end, { desc = "Next failed test" })

require("nvim-test").setup()

-- Tailwind
require("tailwindcss-colorizer-cmp").setup({ color_square_width = 2 })
require("tailwindcss-colors").setup()
