return {
	"sphamba/smear-cursor.nvim",
	-- Kitty already has native cursor_trail; keep nvim smear off to avoid conflicts.
	-- Toggle with :SmearCursorToggle if you want it temporarily.
	opts = {
		enabled = false,
		cursor_color = "#d3cdc3",
		transparent_bg_fallback_color = "#000000",
		legacy_computing_symbols_support = true,
		smear_between_buffers = true,
		smear_between_neighbor_lines = true,
		smear_insert_mode = true,
		vertical_bar_cursor_insert_mode = true,
	},
}
