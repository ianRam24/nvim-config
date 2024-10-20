return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
		config = function()
			local telescope = require("telescope")
			telescope.load_extension("ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>sw", function()
				builtin.grep_string({ search = vim.fn.input("Grep >") })
			end)
			vim.keymap.set("n", "<C-k><C-t>", builtin.colorscheme, {})
			telescope.setup({
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
				},
				defaults = {
					layout_config = {
						horizontal = { preview_cutoff = 0 },
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
		end,
	},
}
