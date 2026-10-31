return {
	{
		"L3MON4D3/LuaSnip",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
			"luckasRanarison/tailwind-tools.nvim",
			"mlaursen/vim-react-snippets",
		},
		config = function()
			local luasnip = require("luasnip")
			luasnip.config.setup({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = false,
			})

			-- VS Code style packs (rafce, rfc, useEffectSnippet, …)
			require("luasnip.loaders.from_vscode").lazy_load()

			-- React/TS snippets (useE → useEffect, useS → useState, rfc, …)
			require("vim-react-snippets").setup({
				readonly_props = false,
			})

			-- Jump through snippet placeholders
			vim.keymap.set({ "i", "s" }, "<C-l>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { silent = true, desc = "Expand/jump snippet forward" })
			vim.keymap.set({ "i", "s" }, "<C-h>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { silent = true, desc = "Jump snippet backward" })
		end,
	},
	{
		"mlaursen/vim-react-snippets",
		lazy = false,
	},
	{
		"rafamadriz/friendly-snippets",
		lazy = false,
	},
	{
		"github/copilot.vim",
		event = "InsertEnter",
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "copilot.vim" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		lazy = false,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			"onsails/lspkind-nvim",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"roobert/tailwindcss-colorizer-cmp.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			-- Distinct colors per completion kind
			local function set_cmp_kind_colors()
				local colors = {
					CmpItemAbbrDeprecated = { fg = "#7E8294", strikethrough = true },
					CmpItemAbbrMatch = { fg = "#82AAFF", bold = true },
					CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bold = true },
					CmpItemMenu = { fg = "#C792EA", italic = true },

					CmpItemKindCopilot = { fg = "#6CC644" },
					CmpItemKindField = { fg = "#B5585F" },
					CmpItemKindProperty = { fg = "#B5585F" },
					CmpItemKindEvent = { fg = "#B5585F" },

					CmpItemKindText = { fg = "#9FBD73" },
					CmpItemKindEnum = { fg = "#9FBD73" },
					CmpItemKindKeyword = { fg = "#9FBD73" },

					CmpItemKindConstant = { fg = "#D4BB6C" },
					CmpItemKindConstructor = { fg = "#D4BB6C" },
					CmpItemKindReference = { fg = "#D4BB6C" },

					CmpItemKindFunction = { fg = "#A377BF" },
					CmpItemKindStruct = { fg = "#A377BF" },
					CmpItemKindClass = { fg = "#A377BF" },
					CmpItemKindModule = { fg = "#A377BF" },
					CmpItemKindOperator = { fg = "#A377BF" },

					CmpItemKindVariable = { fg = "#7E8294" },
					CmpItemKindFile = { fg = "#7E8294" },

					CmpItemKindUnit = { fg = "#D4A959" },
					CmpItemKindSnippet = { fg = "#D4A959" },
					CmpItemKindFolder = { fg = "#D4A959" },

					CmpItemKindMethod = { fg = "#6C8ED4" },
					CmpItemKindValue = { fg = "#6C8ED4" },
					CmpItemKindEnumMember = { fg = "#6C8ED4" },

					CmpItemKindInterface = { fg = "#58B5A8" },
					CmpItemKindColor = { fg = "#58B5A8" },
					CmpItemKindTypeParameter = { fg = "#58B5A8" },
				}

				for group, opts in pairs(colors) do
					vim.api.nvim_set_hl(0, group, opts)
				end
			end

			set_cmp_kind_colors()
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = set_cmp_kind_colors,
			})

			cmp.setup({
				window = {
					completion = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
						col_offset = -3,
						side_padding = 0,
					}),
					documentation = cmp.config.window.bordered({
						border = "rounded",
					}),
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
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "luasnip", priority = 1000 },
					{ name = "nvim_lsp", priority = 900 },
					{ name = "copilot", priority = 800 },
					{ name = "buffer", priority = 500 },
					{ name = "path", priority = 400 },
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = lspkind.cmp_format({
							mode = "symbol",
							maxwidth = 50,
							ellipsis_char = "...",
							show_labelDetails = true,
							symbol_map = {
								Text = "󰉿",
								Method = "󰆧",
								Function = "󰊕",
								Constructor = "",
								Field = "󰜢",
								Variable = "󰀫",
								Class = "󰠱",
								Interface = "",
								Module = "",
								Property = "󰜢",
								Unit = "󰑭",
								Value = "󰎠",
								Enum = "",
								Keyword = "󰌋",
								Snippet = "",
								Color = "󰏘",
								File = "󰈙",
								Reference = "󰈇",
								Folder = "󰉋",
								EnumMember = "",
								Constant = "󰏿",
								Struct = "󰙅",
								Event = "",
								Operator = "󰆕",
								TypeParameter = "󰅲",
								Copilot = "󰚩",
							},
						})(entry, vim_item)

						kind.kind = " " .. kind.kind .. " "
						kind.menu = "  " .. (({
							copilot = "Copilot",
							nvim_lsp = "LSP",
							luasnip = "Snippet",
							buffer = "Buffer",
							path = "Path",
						})[entry.source.name] or entry.source.name)

						kind = require("tailwindcss-colorizer-cmp").formatter(entry, kind)
						return kind
					end,
				},
				experimental = {
					ghost_text = true,
				},
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})

			cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})
		end,
	},
}
