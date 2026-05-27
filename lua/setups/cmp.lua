require("luasnip.loaders.from_vscode").load()

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

local react_config = require("vim-react-snippets.config")
react_config.readonly_props = false

cmp.setup({
	window = {
		completion = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
		}),
		documentation = cmp.config.window.bordered({ border = "rounded" }),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "copilot", group_index = 2 },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				ellipsis_char = "...",
				symbol_map = { Copilot = "󰚩" },
			})(entry, vim_item)

			vim_item.menu = ({
				copilot = "[Copilot]",
				nvim_lsp = "[LSP]",
				luasnip = "[Snip]",
				buffer = "[Buf]",
				path = "[Path]",
			})[entry.source.name] or ""

			vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
			return vim_item
		end,
	},
	experimental = { ghost_text = true },
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ { name = "path" } }, {
		{ name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
	}),
})

cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
	sources = {
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" },
	},
})

require("copilot_cmp").setup()

require("nvim-autopairs").setup({
	check_ts = true,
	ts_config = {
		lua = { "string" },
		javascript = { "template_string" },
		java = false,
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
