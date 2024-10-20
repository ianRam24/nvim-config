return {
	"nvim-treesitter/nvim-treesitter",
	-- when the plugin builds run the TSUpdate command to ensure all our servers are installed and updated
	build = ":TSUpdate",
	config = function()
		-- gain access to the treesitter config functions
		local ts_config = require("nvim-treesitter.configs")

		-- setup nvim-ts-autotag with its own setup function
		require("nvim-ts-autotag").setup()

		-- call the treesitter setup function with properties to configure our experience
		ts_config.setup({
			-- make sure we have vim, vimdoc, lua, java, javascript, typescript, html, css, json, tsx, markdown, markdown_inline and gitignore highlighting servers
			ensure_installed = {
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
			},
			-- make sure highlighting is enabled
			highlight = { enable = true },
		})
	end,
}
