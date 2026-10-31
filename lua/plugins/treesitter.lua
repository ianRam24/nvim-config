return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({})

			local parsers = {
				"vim",
				"vimdoc",
				"lua",
				"java",
				"javascript",
				"typescript",
				"html",
				"css",
				"json",
				"tsx",
				"markdown",
				"markdown_inline",
				"gitignore",
				"regex",
			}
			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true }),
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})

			local ok, autotag = pcall(require, "nvim-ts-autotag")
			if ok then
				autotag.setup()
			end
		end,
	},
	{
		"windwp/nvim-ts-autotag",
	},
}
