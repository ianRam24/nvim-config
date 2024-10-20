-- Set our leader keybinding to space
-- Anywhere you see <leader> in a keymapping specifies the space key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remove search highlights after searching
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlights" })

-- Exit Vim's terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- OPTIONAL: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Easily split windows
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", { desc = "[W]indow Split [V]ertical" })
vim.keymap.set("n", "<leader>wh", ":split<cr>", { desc = "[W]indow Split [H]orizontal" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right in visual mode" })

local move_line_up = function()
	local count = vim.v.count1 -- Obtener el recuento actual con un valor predeterminado de 1
	vim.cmd(":'<,'>m '<-" .. (count + 1)) -- Mover líneas hacia arriba
	vim.cmd("gv=gv") -- Re-seleccionar y re-indentar
end

local move_line_down = function()
	local count = vim.v.count1 -- Obtener el recuento actual con un valor predeterminado de 1
	vim.cmd(":'<,'>m '>+" .. count) -- Mover líneas hacia abajo
	vim.cmd("gv=gv") -- Re-seleccionar y re-indentar
end

vim.keymap.set("v", "K", move_line_up, { desc = "Move line up in visual mode" })
vim.keymap.set("v", "J", move_line_down, { desc = "Move line down in visual mode" })

-- move line
-- vim.keymap.set("v", "J", ":m '>+3<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Search and replace
vim.keymap.set(
	"n",
	"<leader>rw",
	":%s/\\<<C-r><C-w>\\>//gc<Left><Left><Left>",
	{ silent = false, desc = "[R]eplace [W]ord" }
)
vim.keymap.set(
	"n",
	"<leader>RW",
	":%s/\\<<C-r><C-w>\\>//gc<Left><Left><Left>",
	{ silent = false, desc = "[R]eplace [W]ord in file" }
)
