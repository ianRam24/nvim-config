return {
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"mrshmllow/document-color.nvim",
		config = function()
			require("document-color").setup({
				-- Default options
				mode = "background", -- "background" | "foreground" | "single"
			})
		end,
		event = { "BufReadPost", "BufNewFile" }, -- Load on specific events for better performance
	},
}
