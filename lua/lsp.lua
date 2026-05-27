local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function on_attach(_, bufnr)
	local opts = { buffer = bufnr, silent = true }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
	vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
	vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
	vim.keymap.set("n", "<leader>cf", function()
		require("conform").format({ async = true, lsp_format = "fallback" })
	end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
	vim.keymap.set("n", "df", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
end

-- Roslyn (C#) is configured in lua/setups/roslyn.lua via roslyn.nvim + Mason.

local servers = {
	ts_ls = {},
	html = {},
	cssls = {},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = { checkThirdParty = false },
			},
		},
	},
	tailwindcss = {},
	ruff = {},
	dockerls = {},
	clangd = {},
	svelte = {},
	emmet_ls = {},
	eslint = {},
	jsonls = {},
	bashls = {},
	yamlls = {},
	prismals = {},
	cucumber_language_server = {},
	docker_compose_language_service = {},
	quick_lint_js = {},
	biome = {},
	kotlin_lsp = {},
}

for name, config in pairs(servers) do
	vim.lsp.config(name, vim.tbl_deep_extend("force", {
		capabilities = capabilities,
		on_attach = on_attach,
	}, config))
	vim.lsp.enable(name)
end

vim.diagnostic.config({
	virtual_text = { prefix = "●" },
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
