return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		-- Keymap to toggle NeoTree
		vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal right toggle<CR>")

		-- Auto command to close NeoTree when opening a file
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("CloseNeoTreeOnOpen", { clear = true }),
			pattern = "*",
			callback = function()
				if vim.bo.filetype ~= "neo-tree" and vim.fn.expand("%:p") ~= "" then
					vim.cmd("Neotree close")
				end
			end,
		})

		-- Function to handle file creation
		local function on_create_file(node)
			if node.type == "file" then
				vim.cmd("edit " .. node.path)
				vim.cmd("Neotree close")
			end
		end

		-- Setup NeoTree with event handlers and filtered items configuration
		require("neo-tree").setup({
			event_handlers = {
				{
					event = "file_created",
					handler = function(args)
						on_create_file(args)
					end,
				},
			},
			filesystem = {
				filtered_items = {
					visible = true, -- Show hidden files
					hide_dotfiles = false, -- Do not hide dotfiles
					hide_gitignored = false, -- Do not hide gitignored files
					hide_hidden = false, -- Do not hide hidden files
				},
			},
		})
	end,
}
