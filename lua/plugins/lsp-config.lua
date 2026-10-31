-- ~/.config/nvim/lua/plugins/lsp-config.lua
return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup({
				registries = {
					"github:Crashdummyy/mason-registry",
					"github:mason-org/mason-registry",
				},
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
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
					"ruff",
					"kotlin_lsp",
				},
			})
		end,
	},

	{
		"seblyng/roslyn.nvim",
		ft = { "cs", "razor" },
		dependencies = {
			"mason-org/mason.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		---@module 'roslyn.config'
		---@type RoslynNvimConfig
		opts = {
			broad_search = true,
		},
		config = function(_, opts)
			require("roslyn").setup(opts)

			vim.lsp.config("roslyn", {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }
					local snacks = require("snacks")

					vim.keymap.set("n", "gd", function()
						snacks.picker.lsp_definitions()
					end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
					vim.keymap.set("n", "gD", function()
						snacks.picker.lsp_declarations()
					end, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
					-- gI = definition (muscle memory); gi = implementation
					vim.keymap.set("n", "gI", function()
						snacks.picker.lsp_definitions()
					end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
					vim.keymap.set("n", "gi", function()
						snacks.picker.lsp_implementations()
					end, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
					vim.keymap.set("n", "gr", function()
						snacks.picker.lsp_references()
					end, vim.tbl_extend("force", opts, { desc = "References" }))
					-- Docs popup (Noice styles it with border for every LSP)
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover({ border = "rounded", max_width = 80, max_height = 20 })
					end, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))

					-- Signature help (Noice also auto-opens while typing args)
					vim.keymap.set({ "n", "i" }, "<C-k>", function()
						vim.lsp.buf.signature_help({ border = "rounded", max_width = 80 })
					end, vim.tbl_extend("force", opts, { desc = "Signature help" }))

					vim.keymap.set(
						"n",
						"<leader>ca",
						vim.lsp.buf.code_action,
						vim.tbl_extend("force", opts, { desc = "Code action" })
					)
					vim.keymap.set(
						"n",
						"<leader>vrn",
						vim.lsp.buf.rename,
						vim.tbl_extend("force", opts, { desc = "Rename symbol" })
					)
					vim.keymap.set(
						"n",
						"df",
						vim.diagnostic.open_float,
						vim.tbl_extend("force", opts, { desc = "Line diagnostics" })
					)
				end,
			})

			local servers = {
				html = {},
				cssls = {},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = { checkThirdParty = false },
							hint = { enable = true },
							completion = { callSnippet = "Replace" },
						},
					},
				},
				-- Richer hover/docs from TypeScript
				ts_ls = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayFunctionParameterTypeHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayFunctionParameterTypeHints = true,
							},
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
				-- Official JetBrains Kotlin LSP via Mason (`kotlin-lsp` -> intellij-server)
				-- Replaces deprecated fwcd/kotlin-language-server (broken on Fedora Java 25)
				kotlin_lsp = {
					cmd = { "intellij-server", "--stdio" },
				},
			}

			for name, config in pairs(servers) do
				vim.lsp.config(
					name,
					vim.tbl_deep_extend("force", {
						capabilities = capabilities,
					}, config)
				)
				vim.lsp.enable(name)
			end

			vim.diagnostic.config({
				virtual_text = { prefix = "●" },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
	},
}
