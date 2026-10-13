-- Native Neovim 0.12 plugin bootstrap (replaces lazy.nvim)
local M = {}

-- Normalize renamed / moved repos so vim.pack does not see conflicting `src`
local repo_rewrites = {
	["williamboman/mason.nvim"] = "mason-org/mason.nvim",
	["kristijanhusak/vim-dadbod"] = "tpope/vim-dadbod",
}

local function github(repo)
	repo = repo_rewrites[repo] or repo
	return "https://github.com/" .. repo
end

-- Best-effort module names when a spec only provides `opts`
local module_aliases = {
	["sphamba/smear-cursor.nvim"] = "smear_cursor",
	["folke/todo-comments.nvim"] = "todo-comments",
	["folke/which-key.nvim"] = "which-key",
	["folke/noice.nvim"] = "noice",
	["folke/trouble.nvim"] = "trouble",
	["folke/snacks.nvim"] = "snacks",
	["folke/tokyonight.nvim"] = "tokyonight",
	["nvim-lualine/lualine.nvim"] = "lualine",
	["nvim-treesitter/nvim-treesitter"] = "nvim-treesitter",
	["windwp/nvim-autopairs"] = "nvim-autopairs",
	["windwp/nvim-ts-autotag"] = "nvim-ts-autotag",
	["stevearc/oil.nvim"] = "oil",
	["stevearc/overseer.nvim"] = "overseer",
	["akinsho/toggleterm.nvim"] = "toggleterm",
	["lewis6991/gitsigns.nvim"] = "gitsigns",
	["numToStr/Comment.nvim"] = "Comment",
	["echasnovski/mini.icons"] = "mini.icons",
	["rebelot/kanagawa.nvim"] = "kanagawa",
	["EdenEast/nightfox.nvim"] = "nightfox",
	["ellisonleao/gruvbox.nvim"] = "gruvbox",
	["vague-theme/vague.nvim"] = "vague",
	["seblyng/roslyn.nvim"] = "roslyn",
	["williamboman/mason.nvim"] = "mason",
	["mason-org/mason.nvim"] = "mason",
	["williamboman/mason-lspconfig.nvim"] = "mason-lspconfig",
	["neovim/nvim-lspconfig"] = "lspconfig",
	["hrsh7th/nvim-cmp"] = "cmp",
	["L3MON4D3/LuaSnip"] = "luasnip",
	["zbirenbaum/copilot-cmp"] = "copilot_cmp",
	["nvim-neotest/neotest"] = "neotest",
	["mfussenegger/nvim-dap"] = "dap",
	["rcarriga/nvim-dap-ui"] = "dapui",
	["nvimtools/none-ls.nvim"] = "null-ls",
	["stevearc/conform.nvim"] = "conform",
	["smjonas/inc-rename.nvim"] = "inc_rename",
	["MeanderingProgrammer/render-markdown.nvim"] = "render-markdown",
	["meatballs/notebook.nvim"] = "notebook",
	["declancm/cinnamon.nvim"] = "cinnamon",
	["CRAG666/code_runner.nvim"] = "code_runner",
	["mistricky/codesnap.nvim"] = "codesnap",
	["Zeioth/compiler.nvim"] = "compiler",
	["norcalli/nvim-colorizer.lua"] = "colorizer",
	["mrshmllow/document-color.nvim"] = "document-color",
	["themaxmarchuk/tailwindcss-colors.nvim"] = "tailwindcss-colors",
	["luckasRanarison/tailwind-tools.nvim"] = "tailwind-tools",
	["roobert/tailwindcss-colorizer-cmp.nvim"] = "tailwindcss-colorizer-cmp",
	["goolord/alpha-nvim"] = "alpha",
	["rcarriga/nvim-notify"] = "notify",
	["nvim-telescope/telescope.nvim"] = "telescope",
	["iabdelkareem/csharp.nvim"] = "csharp",
	["d7omdev/nuget.nvim"] = "nuget",
	["elmcgill/springboot-nvim"] = "springboot-nvim",
	["klen/nvim-test"] = "nvim-test",
}

local function is_repo(s)
	return type(s) == "string" and s:match("^[%w._-]+/[%w._-]+$") ~= nil and not s:match("^adapter/")
end

local function add_url(urls, seen, repo, version)
	if not is_repo(repo) then
		return
	end
	local url = github(repo)
	if seen[url] then
		return
	end
	seen[url] = true
	if version then
		urls[#urls + 1] = { src = url, version = version }
	else
		urls[#urls + 1] = url
	end
end

local function collect_specs()
	local urls, specs, seen = {}, {}, {}
	local files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/*.lua", false, true)
	table.sort(files)

	local function add_spec(spec)
		if type(spec) ~= "table" then
			return
		end

		-- File returned a list of plugin specs
		if spec[1] and type(spec[1]) == "table" then
			for _, nested in ipairs(spec) do
				add_spec(nested)
			end
			return
		end

		if not is_repo(spec[1]) then
			return
		end

		local version = nil
		if spec.branch then
			version = spec.branch
		elseif spec.version and type(spec.version) == "string" and spec.version ~= "*" then
			version = spec.version
		end

		add_url(urls, seen, spec[1], version)

		if spec.dependencies then
			for _, dep in ipairs(spec.dependencies) do
				if type(dep) == "string" then
					add_url(urls, seen, dep)
				elseif type(dep) == "table" then
					add_spec(dep)
				end
			end
		end

		specs[#specs + 1] = spec
	end

	for _, file in ipairs(files) do
		local name = file:match("plugins/([%w_-]+)%.lua$")
		if name then
			local ok, mod = pcall(require, "plugins." .. name)
			if ok and type(mod) == "table" then
				add_spec(mod)
			else
				vim.notify("Failed loading plugin spec: " .. name .. "\n" .. tostring(mod), vim.log.levels.WARN)
			end
		end
	end

	return urls, specs
end

local function apply_opts(spec)
	local opts = spec.opts
	if type(opts) == "function" then
		opts = opts()
	end
	if opts == nil then
		return
	end

	local modname = module_aliases[spec[1]]
		or spec.name
		or (spec[1]:match("([^/]+)$") or ""):gsub("%.nvim$", ""):gsub("%.lua$", "")

	local candidates = {
		modname,
		modname:gsub("-", "_"),
		modname:gsub("_", "-"),
		(spec[1]:match("([^/]+)$") or ""):gsub("%.nvim$", ""),
	}

	for _, candidate in ipairs(candidates) do
		if candidate and candidate ~= "" then
			local ok, mod = pcall(require, candidate)
			if ok and type(mod) == "table" and type(mod.setup) == "function" then
				local setup_ok, err = pcall(mod.setup, opts)
				if not setup_ok then
					vim.notify("setup failed for " .. spec[1] .. ": " .. err, vim.log.levels.ERROR)
				end
				return
			end
		end
	end
end

-- Support lazy.nvim-style `keys = { { lhs, rhs, desc=..., mode=... }, ... }`
local function apply_keys(spec)
	if type(spec.keys) ~= "table" then
		return
	end

	for _, map in ipairs(spec.keys) do
		if type(map) == "table" and map[1] then
			local lhs = map[1]
			local rhs = map[2]
			local mode = map.mode or "n"
			local opts = {
				desc = map.desc,
				silent = map.silent ~= false,
				noremap = map.noremap ~= false,
				expr = map.expr,
				buffer = map.buffer,
				nowait = map.nowait,
			}
			local ok, err = pcall(vim.keymap.set, mode, lhs, rhs, opts)
			if not ok then
				vim.notify(
					"keymap failed for " .. tostring(spec[1]) .. " [" .. tostring(lhs) .. "]: " .. err,
					vim.log.levels.WARN
				)
			end
		end
	end
end

function M.setup()
	local urls, specs = collect_specs()

	-- Load during init.lua (vim.pack defaults load=false while sourcing init)
	vim.pack.add(urls, { load = true, confirm = false })

	for _, spec in ipairs(specs) do
		if type(spec.config) == "function" then
			local ok, err = pcall(spec.config, nil, spec.opts or {})
			if not ok then
				vim.notify("config failed for " .. tostring(spec[1]) .. ":\n" .. err, vim.log.levels.ERROR)
			end
		elseif spec.opts ~= nil then
			apply_opts(spec)
		end

		apply_keys(spec)
	end
end

return M
