return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local lualine = require("lualine")
		lualine.get_config().options.theme = "gruvbox-material"
		lualine.setup()
	end,
}
