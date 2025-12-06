-- ~/.config/nvim/lua/plugins/lsp-config.lua
return {
	{
		"williamboman/mason.nvim",
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
					"pylsp",
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
				},
			})
		end,
	},

	{
		"seblyng/roslyn.nvim",
		ft = { "cs", "razor" },
		dependencies = { "tris203/rzls.nvim" },
		config = function()
			local rzls_path = vim.fn.expand("$MASON/packages/rzls/libexec")

			require("roslyn").setup({
				cmd = {
					"roslyn",
					"--stdio",
					"--logLevel=Information",
					"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
					"--razorSourceGenerator="
						.. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
					"--razorDesignTimePath="
						.. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
					"--extension",
					vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
				},
				handlers = require("rzls.roslyn_handlers"),
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(_, bufnr)
				local opts = { buffer = bufnr }
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			end

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
				pylsp = {},
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
				roslyn = {},
			}

			-- 🧠 Nueva API (Neovim 0.11+)
			for name, config in pairs(servers) do
				vim.lsp.config[name] = vim.tbl_deep_extend("force", {
					capabilities = capabilities,
					on_attach = on_attach,
				}, config)

				vim.lsp.enable(name)
			end

			-- Diagnósticos visuales
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
