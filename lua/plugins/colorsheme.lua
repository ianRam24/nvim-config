return {
	{
		"sainnhe/gruvbox-material",
		name = "gruvbox-material", -- Add explicit name
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_transparent_background = 1
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "mix"
			vim.g.gruvbox_material_enable_italic = true
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa", -- Add explicit name
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				transparent = true,
				colors = {
					palette = {
						sumiInk0 = "#000000",
						fujiWhite = "#FFFFFF",
					},
					theme = {
						wave = {
							ui = {
								float = {
									bg = "none",
								},
							},
						},
						dragon = {
							syn = {
								parameter = "#FF6347",
							},
						},
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				overrides = function(colors)
					local theme = colors.theme
					return {
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },
						NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
						LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						String = { fg = colors.palette.carpYellow, italic = true },
						Parameter = { fg = "#FF6347", italic = true },
					}
				end,
				borderStyle = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
			})
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		name = "nightfox", -- Add explicit name
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
				},
			})
		end,
	},
	{
		"sainnhe/sonokai",
		name = "sonokai", -- Add explicit name
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.sonokai_enable_italic = true
			vim.g.sonokai_style = "andromeda"
		end,
	},
	{
		"sainnhe/everforest",
		name = "everforest", -- Add explicit name
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.everforest_enable_italic = true
			vim.g.everforest_background = "soft"
			vim.g.everforest_transparent_background = 1
		end,
	},
}
