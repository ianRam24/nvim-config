local M = {}

local function get_jdtls()
	local ok, mason_registry = pcall(require, "mason-registry")
	if not ok then
		vim.notify("Could not load mason-registry", vim.log.levels.ERROR)
		return nil, nil, nil
	end

	if not mason_registry.has_package("jdtls") then
		vim.notify("jdtls is not installed via Mason", vim.log.levels.ERROR)
		return nil, nil, nil
	end

	local jdtls_pkg = mason_registry.get_package("jdtls")
	local jdtls_path = jdtls_pkg and jdtls_pkg.install_path or nil
	if not jdtls_path or jdtls_path == "" then
		return nil, nil, nil
	end

	local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
	local config = jdtls_path .. "/config_linux"
	local lombok = jdtls_path .. "/lombok.jar"
	return launcher, config, lombok
end

local function get_bundles()
	local mason_registry = require("mason-registry")
	local bundles = {}

	if mason_registry.has_package("java-debug-adapter") then
		local path = mason_registry.get_package("java-debug-adapter").install_path
		table.insert(bundles, vim.fn.glob(path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1))
	end

	if mason_registry.has_package("java-test") then
		local path = mason_registry.get_package("java-test").install_path
		vim.list_extend(bundles, vim.split(vim.fn.glob(path .. "/extension/server/*.jar", 1), "\n"))
	end

	return bundles
end

local function get_workspace()
	local home = os.getenv("HOME")
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	return home .. "/code/workspace/" .. project_name
end

local function java_keymaps()
	vim.keymap.set("n", "<leader>Jo", "<Cmd>lua require('jdtls').organize_imports()<CR>", { desc = "Java organize imports" })
	vim.keymap.set("n", "<leader>Jv", "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = "Java extract variable" })
	vim.keymap.set("v", "<leader>Jv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { desc = "Java extract variable" })
	vim.keymap.set("n", "<leader>JC", "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = "Java extract constant" })
	vim.keymap.set("v", "<leader>JC", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { desc = "Java extract constant" })
	vim.keymap.set("n", "<leader>Jt", "<Cmd>lua require('jdtls').test_nearest_method()<CR>", { desc = "Java test method" })
	vim.keymap.set("v", "<leader>Jt", "<Esc><Cmd>lua require('jdtls').test_nearest_method(true)<CR>", { desc = "Java test method" })
	vim.keymap.set("n", "<leader>JT", "<Cmd>lua require('jdtls').test_class()<CR>", { desc = "Java test class" })
	vim.keymap.set("n", "<leader>Ju", "<Cmd>JdtUpdateConfig<CR>", { desc = "Java update config" })
end

function M.setup_jdtls()
	local jdtls = require("jdtls")
	local launcher, os_config, lombok = get_jdtls()
	if not launcher or not os_config or not lombok then
		return
	end

	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local extended = jdtls.extendedClientCapabilities
	extended.resolveAdditionalTextEditsSupport = true

	local cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. lombok,
		"-jar",
		launcher,
		"-configuration",
		os_config,
		"-data",
		get_workspace(),
	}

	jdtls.start_or_attach({
		cmd = cmd,
		root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
		settings = {
			java = {
				format = { enabled = true },
				eclipse = { downloadSources = true },
				maven = { downloadSources = true },
				signatureHelp = { enabled = true },
				saveActions = { organizeImports = true },
				configuration = { updateBuildConfiguration = "interactive" },
				referencesCodeLens = { enabled = true },
				inlayHints = { parameterNames = { enabled = "all" } },
			},
		},
		capabilities = capabilities,
		init_options = {
			bundles = get_bundles(),
			extendedClientCapabilities = extended,
		},
		on_attach = function()
			java_keymaps()
			require("jdtls.dap").setup_dap()
			require("jdtls.dap").setup_dap_main_class_configs()
			require("jdtls.setup").add_commands()
			vim.lsp.codelens.refresh()
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = "*.java",
				callback = function()
					pcall(vim.lsp.codelens.refresh)
				end,
			})
		end,
	})
end

return M
