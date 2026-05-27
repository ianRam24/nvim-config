vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_foreground = "mix"
vim.g.gruvbox_material_enable_italic = true

require("kanagawa").setup({
	transparent = true,
	theme = {
		wave = { ui = { float = { bg = "none" } } },
		dragon = { syn = {}, all = { ui = { bg_gutter = "none" } } },
	},
	overrides = function(colors)
		local theme = colors.theme
		return {
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
			Parameter = { italic = true },
		}
	end,
	borderStyle = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
})

require("nightfox").setup({ options = { transparent = true } })

vim.g.sonokai_enable_italic = true
vim.g.sonokai_style = "andromeda"

vim.g.everforest_enable_italic = true
vim.g.everforest_background = "soft"
vim.g.everforest_transparent_background = 1

vim.g.moonflyTransparent = true
vim.g.edge_enable_italic = true
vim.g.edge_transparent_background = 1
vim.g.nightflyTransparent = true

require("vague").setup({ transparent = true, italics = true })

require("gruvbox").setup({ transparent_mode = true })

require("tokyonight").setup({ style = "night", transparent = true })
