return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
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
							parameter = "#FF6347", -- Color naranja (puedes ajustar este hex)
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
					Parameter = { fg = "#FF6347", italic = true }, -- Agregado para asegurar el estilo de parámetro
				}
			end,
			borderStyle = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
		})
		--	vim.cmd.colorscheme("kanagawa-dragon")
	end,
}
