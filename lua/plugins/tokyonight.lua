return {
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = true,
				-- Aquí puedes agregar otras configuraciones si es necesario
			})
			--      vim.cmd.colorscheme("tokyonight")
		end,
	},
}
