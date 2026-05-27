require("mason").setup({
	registries = {
		"github:Crashdummyy/mason-registry",
		"github:mason-org/mason-registry",
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"ts_ls",
		"html",
		"cssls",
		"lua_ls",
		"tailwindcss",
		"dockerls",
		"clangd",
		"svelte",
		"emmet_ls",
		"eslint",
		"jsonls",
		"bashls",
		"yamlls",
		"prismals",
		"cucumber_language_server",
		"docker_compose_language_service",
		"quick_lint_js",
		"biome",
		"kotlin_lsp",
		"ruff",
	},
})
