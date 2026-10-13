return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 15, -- tamaño de la terminal horizontal
			open_mapping = [[<c-\>]], -- puedes abrir rápido con Ctrl+\
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "horizontal", -- terminal por defecto
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "rounded",
				width = math.floor(vim.o.columns * 0.75),
				height = math.floor(vim.o.lines * 0.6),
				winblend = 10, -- leve transparencia
				title = "Popup Terminal",
				title_pos = "center",
			},
		})

		-- 🔹 Terminal flotante centrada
		local Terminal = require("toggleterm.terminal").Terminal
		local popup = Terminal:new({
			direction = "float",
			float_opts = {
				border = "rounded",
				winblend = 10,
				title = "Popup Terminal",
				title_pos = "center",
			},
		})

		-- Atajos de teclado
		vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Terminal abajo" })
		vim.keymap.set("n", "<leader>tp", function()
			popup:toggle()
		end, { desc = "Terminal popup centrada" })

		-- 🔹 Ocultar statusline y ruler dentro de terminal
		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "*",
			callback = function()
				vim.opt_local.number = false
				vim.opt_local.relativenumber = false
				vim.opt_local.ruler = false
				vim.opt_local.laststatus = 0
			end,
		})
	end,
}
