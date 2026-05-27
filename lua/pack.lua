-- Plugins from master, installed via Neovim 0.12 vim.pack
vim.pack.add({
	-- Shared dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-mini/mini.icons",

	-- LSP / Mason
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/seblyng/roslyn.nvim",

	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
	"https://github.com/windwp/nvim-ts-autotag",

	-- Completion
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/saadparwaiz1/cmp_luasnip",
	"https://github.com/luckasRanarison/tailwind-tools.nvim",
	"https://github.com/mlaursen/vim-react-snippets",
	"https://github.com/github/copilot.vim",
	"https://github.com/zbirenbaum/copilot-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/onsails/lspkind-nvim",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-cmdline",
	"https://github.com/roobert/tailwindcss-colorizer-cmp.nvim",

	-- UI
	"https://github.com/folke/snacks.nvim",
	"https://github.com/folke/noice.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/rcarriga/nvim-notify",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/folke/todo-comments.nvim",

	-- Editing
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/smjonas/inc-rename.nvim",
	"https://github.com/mg979/vim-visual-multi",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/meatballs/notebook.nvim",

	-- Colorschemes
	"https://github.com/sainnhe/gruvbox-material",
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/EdenEast/nightfox.nvim",
	"https://github.com/sainnhe/sonokai",
	"https://github.com/sainnhe/everforest",
	"https://github.com/bluz71/vim-moonfly-colors",
	"https://github.com/sainnhe/edge",
	"https://github.com/bluz71/vim-nightfly-colors",
	"https://github.com/vague-theme/vague.nvim",
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/folke/tokyonight.nvim",

	-- Tools
	"https://github.com/declancm/cinnamon.nvim",
	"https://github.com/CRAG666/code_runner.nvim",
	"https://github.com/mistricky/codesnap.nvim",
	"https://github.com/mrshmllow/document-color.nvim",
	"https://github.com/Zeioth/compiler.nvim",
	{ src = "https://github.com/stevearc/overseer.nvim", rev = "6271cab7ccc4ca840faa93f54440ffae3a3918bd" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", rev = "5255aa27c422de944791318024167ad5d40aad20" },
	"https://github.com/kristijanhusak/vim-dadbod",
	"https://github.com/kristijanhusak/vim-dadbod-completion",
	"https://github.com/kristijanhusak/vim-dadbod-ui",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/akinsho/toggleterm.nvim",
	"https://github.com/nvim-neotest/neotest",
	"https://github.com/antoinemadec/FixCursorHold.nvim",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/nvim-neotest/neotest-jest",
	"https://github.com/rcasia/neotest-java",
	"https://github.com/klen/nvim-test",

	-- Debug
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
	"https://github.com/mfussenegger/nvim-jdtls",

	-- Format
	"https://github.com/stevearc/conform.nvim",

	-- Java / C#
	"https://github.com/elmcgill/springboot-nvim",
	"https://github.com/d7omdev/nuget.nvim",
	"https://github.com/iabdelkareem/csharp.nvim",
	"https://github.com/Tastyep/structlog.nvim",

	-- Tailwind
	"https://github.com/themaxmarchuk/tailwindcss-colors.nvim",
})

require("setups")
