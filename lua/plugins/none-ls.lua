-- Formatting moved to conform.nvim (lua/plugins/conform.lua).
-- Keep none-ls only for optional diagnostics that are not covered by LSP.
return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				require("none-ls.diagnostics.eslint_d"),
				null_ls.builtins.diagnostics.erb_lint,
			},
		})
	end,
}
