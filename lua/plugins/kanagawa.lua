return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			--      transparent = true,  -- Activar la transparencia
		})
		-- vim.cmd.colorscheme("kanagawa-dragon")
	end,
}
