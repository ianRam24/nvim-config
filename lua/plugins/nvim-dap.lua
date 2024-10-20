return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		-- Gain access to the dap plugin and its functions
		local dap = require("dap")
		-- Gain access to the dap ui plugin and its functions
		local dapui = require("dapui")
		local dap_virtual_text = require("nvim-dap-virtual-text")

		-- Setup the dap ui with default configuration
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

		-- Setup an event listener for when the debugger is launched
		dap.listeners.before.launch.dapui_config = function()
			-- When the debugger is launched open up the debug ui
			dapui.open()
		end

		-- Set a vim motion for <Space> + d + t to toggle a breakpoint at the line where the cursor is currently on
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebug toggle [B]reakpoint" })

		-- Set a vim motion for <Space> + d + s to start the debugger and launch the debugging ui
		vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[D]ebug [C]ontinue" })

		-- Set a vim motion to close the debugging ui
		vim.keymap.set("n", "<leader>dc", dapui.close, { desc = "[D]ebug [C]lose" })

		-- Import the JavaScript configuration
		require("config.js-dap")
	end,
}
