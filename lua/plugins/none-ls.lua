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
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.diagnostics.erb_lint,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
			},
		})

		vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
		local format_on_save = function()
			vim.lsp.buf.format()
		end

		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = format_on_save,
		})
	end,
}
