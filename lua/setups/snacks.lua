require("snacks").setup({
	styles = {
		input = {
			keys = {},
			n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
			i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
		},
	},
	input = { enabled = true },
	quickfile = { enabled = true, exclude = { "latex" } },
	picker = {
		enabled = true,
		matchers = { frecency = true, cwd_bonus = false },
		formatters = {
			file = { filename_first = false, filename_only = false, icon_width = 2 },
		},
		layout = { preset = "telescope", cycle = false },
		sources = {
			explorer = {
				hidden = true,
				follow_file = true,
				formatters = {
					file = { filename_only = true, icon_width = 2 },
				},
				layout = {
					preset = "right",
					preview = false,
					layout = { width = 30, position = "right" },
				},
			},
		},
	},
	image = {
		enabled = true,
		doc = { float = true, inline = false, max_width = 50, max_height = 30, wo = { wrap = false } },
		convert = { notify = true, command = "magick" },
	},
	dashboard = {
		enabled = true,
		preset = {
			header = table.concat({
			[[                    ***********************                    ]],
			[[               *********************************               ]],
			[[           *******   *     *       *    *    *******           ]],
			[[        *******   ***      **     **     ***   *******        ]],
			[[      ******   *****       *********      *****    *****      ]],
			[[    ******  ********       *********       ******    *****    ]],
			[[   ****   **********       *********       *********   *****  ]],
			[[  ****  **************    ***********     ************   **** ]],
			[[ ****  *************************************************  **** ]],
			[[****  ***************************************************  ****]],
			[[****  ****************************************************  ****]],
			[[****  ****************************************************  ****]],
			[[ ****  ***************************************************  ****]],
			[[  ****  *******     ****  ***********  ****     *********  **** ]],
			[[   ****   *****      *      *******      *      ********  ****  ]],
			[[    *****   ****             *****             ******   *****   ]],
			[[      *****   **              ***              **    ******     ]],
			[[       ******   *              *              *   *******       ]],
			[[         *******                                *******         ]],
			[[            ********                         *******            ]],
			[[               *********************************               ]],
			[[                    ***********************                    ]],
			}, "\n"),
		},
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
		},
	},
	notifier = { enabled = true },
	explorer = { enabled = true },
})

local snacks = require("snacks")

vim.keymap.set("n", "<C-p>", function() snacks.picker.files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader><space>", function() snacks.picker.smart() end, { desc = "Smart find files" })
vim.keymap.set("n", "<leader>pc", function()
	snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find config file" })
vim.keymap.set("n", "<leader>ps", function() snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set({ "n", "x" }, "<leader>pws", function() snacks.picker.grep_word() end, { desc = "Grep word/selection" })
vim.keymap.set("n", "<leader>pk", function() snacks.picker.keymaps({ layout = "ivy" }) end, { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>th", function() snacks.picker.colorschemes({ layout = "ivy" }) end, { desc = "Colorschemes" })
vim.keymap.set("n", "<leader>vh", function() snacks.picker.help() end, { desc = "Help pages" })

vim.keymap.set("n", "gd", function() snacks.picker.lsp_definitions() end, { desc = "Goto definition" })
vim.keymap.set("n", "gD", function() snacks.picker.lsp_declarations() end, { desc = "Goto declaration" })
vim.keymap.set("n", "gI", function() snacks.picker.lsp_implementations() end, { desc = "Goto implementation" })

vim.keymap.set("n", "<leader>lg", function() snacks.lazygit() end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gl", function() snacks.lazygit.log() end, { desc = "Lazygit logs" })
vim.keymap.set("n", "<leader>gbr", function()
	snacks.picker.git_branches({ layout = "select" })
end, { desc = "Git branches" })

vim.keymap.set("n", "<leader>rN", function() snacks.rename.rename_file() end, { desc = "Rename file" })
vim.keymap.set("n", "<leader>dB", function() snacks.bufdelete() end, { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>e", function() snacks.explorer() end, { desc = "File explorer" })
