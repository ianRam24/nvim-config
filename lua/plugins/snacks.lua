return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	opts = {
		styles = {
			input = {
				keys = {},
				n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
				i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
			},
		},

		input = { enabled = true },

		quickfile = {
			enabled = true,
			exclude = { "latex" },
		},

		picker = {
			enabled = true,
			matchers = {
				frecency = true,
				cwd_bonus = false,
			},
			formatters = {
				file = {
					filename_first = false,
					filename_only = false,
					icon_width = 2,
				},
			},
			layout = {
				preset = "telescope",
				cycle = false,
			},
			layouts = {
				select = {
					preview = false,
					layout = {
						backdrop = false,
						width = 0.6,
						min_width = 80,
						height = 0.4,
						min_height = 10,
						box = "vertical",
						border = "rounded",
						title = "{title}",
						title_pos = "center",
						{ win = "input", height = 1, border = "bottom" },
						{ win = "list", border = "none" },
						{ win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
					},
				},
				telescope = {
					reverse = true,
					layout = {
						box = "horizontal",
						backdrop = false,
						width = 0.8,
						height = 0.9,
						border = "none",
						{
							box = "horizontal",
							{
								win = "preview",
								title = "{preview:Preview}",
								width = 0.5,
								border = "rounded",
								title_pos = "center",
							},
							{
								box = "vertical",
								{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
								{
									win = "input",
									height = 1,
									border = "rounded",
									title = "{title} {live} {flags}",
									title_pos = "center",
								},
							},
						},
					},
				},
				ivy = {
					layout = {
						box = "vertical",
						backdrop = false,
						width = 0,
						height = 0.4,
						position = "bottom",
						border = "top",
						title = " {title} {live} {flags}",
						title_pos = "left",
						{ win = "input", height = 1, border = "bottom" },
						{
							box = "horizontal",
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.5, border = "left" },
						},
					},
				},
			},
		},

		image = {
			enabled = true,
			doc = {
				float = true,
				inline = false,
				max_width = 50,
				max_height = 30,
				wo = { wrap = false },
			},
			convert = {
				notify = true,
				command = "magick",
			},
			img_dirs = {
				"img",
				"images",
				"assets",
				"static",
				"public",
				"media",
				"attachments",
				"Archives/All-Vault-Images/",
				"~/Library",
				"~/Downloads",
			},
		},

		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
				{
					section = "terminal",
					random = 15,
					pane = 2,
					indent = 15,
					height = 20,
				},
			},
		},

		explorer = {
			enabled = true,
			replace_netrw = true,
		},
	},
	config = function(_, opts)
		local snacks = require("snacks")
		snacks.setup(opts)

		-- Keymaps must be registered here under vim.pack (lazy `keys` alone is not enough)
		vim.keymap.set("n", "<C-p>", function()
			snacks.picker.files()
		end, { desc = "Find Files" })
		vim.keymap.set("n", "<leader><space>", function()
			snacks.picker.smart()
		end, { desc = "Smart Find Files" })
		vim.keymap.set("n", "<leader>pc", function()
			snacks.picker.files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Find Config File" })
		vim.keymap.set("n", "<leader>ps", function()
			snacks.picker.grep()
		end, { desc = "Grep" })
		vim.keymap.set({ "n", "x" }, "<leader>pws", function()
			snacks.picker.grep_word()
		end, { desc = "Grep Word/Selection" })
		vim.keymap.set("n", "<leader>pk", function()
			snacks.picker.keymaps({ layout = "ivy" })
		end, { desc = "Search Keymaps" })
		vim.keymap.set("n", "<leader>th", function()
			snacks.picker.colorschemes({ layout = "ivy" })
		end, { desc = "Colorschemes" })
		vim.keymap.set("n", "<leader>vh", function()
			snacks.picker.help()
		end, { desc = "Help Pages" })

		vim.keymap.set("n", "gd", function()
			snacks.picker.lsp_definitions()
		end, { desc = "Goto Definition" })
		vim.keymap.set("n", "gD", function()
			snacks.picker.lsp_declarations()
		end, { desc = "Goto Declaration" })
		vim.keymap.set("n", "gI", function()
			snacks.picker.lsp_implementations()
		end, { desc = "Goto Implementation" })

		vim.keymap.set("n", "<leader>lg", function()
			snacks.lazygit()
		end, { desc = "Lazygit" })
		vim.keymap.set("n", "<leader>gl", function()
			snacks.lazygit.log()
		end, { desc = "Lazygit Logs" })
		vim.keymap.set("n", "<leader>gbr", function()
			snacks.picker.git_branches({ layout = "select" })
		end, { desc = "Git Branches" })

		vim.keymap.set("n", "<leader>rN", function()
			snacks.rename.rename_file()
		end, { desc = "Rename File" })
		vim.keymap.set("n", "<leader>dB", function()
			snacks.bufdelete()
		end, { desc = "Delete Buffer" })
		vim.keymap.set("n", "<leader>e", function()
			snacks.explorer()
		end, { desc = "File Explorer" })
	end,
}
