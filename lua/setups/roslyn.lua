-- C# via roslyn.nvim (Mason package: roslyn from Crashdummyy registry)
require("roslyn").setup({ broad_search = true })

local function ensure_roslyn()
	local ok, registry = pcall(require, "mason-registry")
	if not ok or not registry.has_package("roslyn") then
		return
	end

	if registry.is_installed("roslyn") then
		vim.lsp.enable("roslyn")
		return
	end

	vim.notify("Installing roslyn via Mason (C# LSP)...", vim.log.levels.INFO)
	registry.get_package("roslyn"):install(function(success)
		if success then
			vim.lsp.enable("roslyn")
		else
			vim.notify("Run :MasonInstall roslyn for C# support", vim.log.levels.WARN)
		end
	end)
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MasonRegistryUpdateDone",
	callback = ensure_roslyn,
})

vim.schedule(ensure_roslyn)
