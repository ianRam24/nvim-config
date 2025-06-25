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
        ensure_installed = { "lua_ls", "ts_ls", "jdtls" },
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
    "themaxmarchuk/tailwindcss-colors.nvim",
    lazy = true,
    module = "tailwindcss-colors",
    config = function()
      require("tailwindcss-colors").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Add Tailwind colorProvider support
      capabilities.textDocument.colorProvider = { dynamicRegistration = true }

      local on_attach = function(client, bufnr)
        -- Optional: disable semanticTokens if needed
        if client.server_capabilities.semanticTokensProvider then
          client.server_capabilities.semanticTokensProvider = nil
        end

        -- Attach tailwind colorizer
        if client.server_capabilities.colorProvider then
          require("document-color").buf_attach(bufnr)
        end
      end

      -- Omnisharp setup
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
        "nextls",
        "tailwindcss",
        "pylsp",
        "eslint",
        "quick_lint_js",
        "emmet_ls",
        "prismals",
        "cucumber_language_server",
        "svelte",
        "dockerls",
        "docker_compose_language_service",
        "csharp_ls"
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      -- Signs & Diagnostics UI
      local signs = {
        Error = " ",
        Warn = " ",
        Hint = "󰠠 ",
        Info = " "
      }
      for type, icon in pairs(signs) do
        vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type })
      end

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          severity = { min = vim.diagnostic.severity.INFO },
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- LSP Keymaps
      vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
      vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
      vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references,
        { desc = "[C]ode Goto [R]eferences" })
      vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations,
        { desc = "[C]ode Goto [I]mplementations" })
      vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
      vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
    end,
  },
}
