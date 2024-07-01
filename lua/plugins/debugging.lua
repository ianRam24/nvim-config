local js_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"mfussenegger/nvim-jdtls",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
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
			element_mappings = {},
			expand_lines = true,
			floating = {
				max_height = nil,
				max_width = nil,
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			force_buffers = true,
			icons = {
				collapsed = "",
				current_frame = "",
				expanded = "",
			},
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
			render = {
				max_type_length = nil,
			},
		})

		dap_virtual_text.setup()

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "127.0.0.1",
			port = 8123,
			executable = {
				command = "js-debug-adapter",
			},
		}
		-- Java Debugging
		-- Java DAP adapter
		dap.adapters.java = function(callback)
			-- Customize the adapter here if needed
			callback({
				type = "server",
				host = "127.0.0.1",
				port = 5005,
				executable = {
					command = "java",
					args = {
						"-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,quiet=y,address=5005",
						"-jar",
						vim.fn.expand("~/path/to/java-debug.jar"),
					},
				},
			})
		end

		dap.configurations.java = {
			{
				type = "java",
				request = "attach",
				name = "Debug (Attach) - Remote",
				hostName = "127.0.0.1",
				port = 5005,
			},
			{
				type = "java",
				request = "launch",
				name = "Launch",
				mainClass = "${file}",
				projectName = "YourProjectName",
			},
		}
		for _, language in pairs(js_languages) do
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
						local url =
							coroutine.yield(vim.ui.input({ prompt = "Enter URL", default = "http://localhost:3000" }))
						return url or "http://localhost:3000"
					end,
					webRoot = "${workspaceFolder}",
					skipFiles = { "<node_internals>/**/*.js" },
					protocol = "inspector",
					sourceMaps = true,
					userDataDir = false,
				},
				{
					name = "========== Launch .json configs ==========",
					type = "",
					request = "launch",
				},
			}
		end

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.api.nvim_set_keymap(
			"n",
			"<F5>",
			":lua require'dapui'.open(); require'dap'.continue()<CR>",
			{ noremap = true, silent = true }
		)

		-- Toggle breakpoint with <leader>db
		vim.api.nvim_set_keymap(
			"n",
			"<leader>db",
			":lua require'dap'.toggle_breakpoint()<CR>",
			{ noremap = true, silent = true }
		)
	end,
}
