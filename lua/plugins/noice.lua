return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("notify").setup({
			background_colour = "#000000",
		})

		require("noice").setup({
			notify = {
				timeout = 1000,
			},
			lsp = {
				-- Pretty hover docs for ALL language servers (TS, C#, Java, Lua, …)
				hover = {
					enabled = true,
					silent = true,
				},
				-- Signature help while typing function args: foo(|)
				signature = {
					enabled = true,
					auto_open = {
						enabled = true,
						trigger = true,
						luasnip = true,
						throttle = 50,
					},
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				lsp_doc_border = true, -- border around hover + signature (like the lua example)
				long_message_to_split = true,
			},
			views = {
				hover = {
					border = { style = "rounded" },
					size = { max_width = 80, max_height = 20 },
				},
			},
		})

		vim.keymap.set("n", "<leader>nd", ":NoiceDismiss<CR>", {
			noremap = true,
			silent = true,
			desc = "Dismiss notifications",
		})
	end,
}
