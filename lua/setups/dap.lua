local dap = require("dap")
local dapui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")

dapui.setup({
	controls = {
		enabled = true,
		element = "repl",
		icons = {
			pause = "",
			play = "",
			step_into = "",
			step_over = "",
			step_out = "",
			step_back = "",
			run_last = "↻",
			terminate = "□",
		},
	},
	expand_lines = true,
	floating = {
		border = "single",
		mappings = { close = { "q", "<Esc>" } },
	},
	force_buffers = true,
	icons = { collapsed = "", current_frame = "", expanded = "" },
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.25 },
				{ id = "breakpoints", size = 0.25 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.25 },
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				{ id = "repl", size = 0.5 },
				{ id = "console", size = 0.5 },
			},
			size = 10,
			position = "bottom",
		},
	},
	mappings = {
		edit = "e",
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		repl = "r",
		toggle = "t",
	},
})

dap_virtual_text.setup()

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

-- JavaScript / TypeScript
dap.adapters["pwa-node"] = {
	type = "server",
	host = "127.0.0.1",
	port = 8123,
	executable = { command = "js-debug-adapter" },
}

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
			runtimeExecutable = "node",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
			sourceMaps = true,
		},
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch & Debug Chrome",
			url = function()
				return coroutine.yield(vim.ui.input({
					prompt = "Enter URL",
					default = "http://localhost:3000",
				})) or "http://localhost:3000"
			end,
			webRoot = "${workspaceFolder}",
			skipFiles = { "<node_internals>/**/*.js" },
			protocol = "inspector",
			sourceMaps = true,
			userDataDir = false,
		},
	}
end

-- C / C++ / Rust via codelldb
dap.adapters.codelldb = function(callback, _)
	local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
	callback({
		type = "server",
		host = "127.0.0.1",
		port = "${port}",
		executable = {
			command = mason_path .. "adapter/codelldb",
			args = { "--liblldb", mason_path .. "lldb/lib/liblldb.so", "--port", "${port}" },
		},
	})
end

local cpp_config = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}
dap.configurations.cpp = cpp_config
dap.configurations.c = cpp_config
dap.configurations.rust = cpp_config

dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

vim.keymap.set("n", "<F5>", function()
	dapui.open()
	dap.continue()
end, { desc = "Debug continue" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug toggle breakpoint" })
vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "Debug start" })
vim.keymap.set("n", "<leader>dq", dap.close, { desc = "Debug quit" })

vim.api.nvim_create_user_command("DebugToggleBreakpoint", function() dap.toggle_breakpoint() end, {})
vim.api.nvim_create_user_command("DebugStart", function() dap.continue() end, {})
vim.api.nvim_create_user_command("DebugClose", function() dapui.close() end, {})
