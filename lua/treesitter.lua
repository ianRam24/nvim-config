local treesitter = require("nvim-treesitter")

if vim.fn.executable("tree-sitter") == 0 then
	vim.notify(
		"tree-sitter-cli >= 0.26.1 required (e.g. `sudo dnf install tree-sitter-cli`) — see :checkhealth nvim-treesitter",
		vim.log.levels.WARN
	)
end

treesitter.setup({})

local ensure_installed = {
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
	"go",
	"rust",
	"bash",
	"http",
	"dockerfile",
	"regex",
}

treesitter.install(ensure_installed):wait(300000)

require("nvim-ts-autotag").setup()

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function()
		pcall(function()
			treesitter.update():wait(300000)
		end)
	end,
})
