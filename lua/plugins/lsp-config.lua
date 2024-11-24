return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "jdtls" },
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "java-debug-adapter", "java-test" },
			})
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Add colorProvider capability
			capabilities.textDocument.colorProvider = { dynamicRegistration = true }

			local on_attach = function(client, bufnr)
				-- Disable semanticTokensProvider if it causes errors
				if client.server_capabilities.semanticTokensProvider then
					client.server_capabilities.semanticTokensProvider = nil
				end

				-- Call the color plugin's attach function
				if client.server_capabilities.colorProvider then
					require("document-color").buf_attach(bufnr)
				end
			end

			-- Configure Omnisharp
			lspconfig.omnisharp.setup({
				cmd = { "dotnet", "/home/acer/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
				capabilities = capabilities,
				on_attach = on_attach,
			})
			local servers = {
				"ts_ls",
				"cssls",
				"html",
				"lua_ls",
				"jdtls",
				"tailwindcss",
				"pyright",
				"eslint",
				"quick_lint_js",
				"emmet_ls",
				"prismals",
				"cucumber_language_server",
				"svelte",
				"dockerls",
				"docker_compose_language_service",
			}
			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
					on_attach = function(client)
						client.server_capabilities.semanticTokensProvider = nil -- Desactiva tokens semánticos para evitar el error
					end,
				})
			end
			-- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
			vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
			-- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
			vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
			-- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
			-- Set vim motion for <Space> + c + r to display references to the code under the cursor
			vim.keymap.set(
				"n",
				"<leader>cr",
				require("telescope.builtin").lsp_references,
				{ desc = "[C]ode Goto [R]eferences" }
			)
			-- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
			vim.keymap.set(
				"n",
				"<leader>ci",
				require("telescope.builtin").lsp_implementations,
				{ desc = "[C]ode Goto [I]mplementations" }
			)
			-- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
			vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
			-- Set a vim motion for <Space> + c + <Shift>D to go to where the code/object was declared in the project (class file)
			vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
		end,
	},
}
