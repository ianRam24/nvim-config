return {
	"declancm/cinnamon.nvim",
	version = "*",
	config = function()
		require("cinnamon").setup({
			keymaps = {
				extra = true, -- Replaces `extra_keymaps`
			},
			options = {
				override_keymaps = true, -- Replaces `override_keymaps`
				max_delta = {
					time = 500, -- Replaces `max_length`
					line = -1, -- Replaces `scroll_limit`
				},
			},
		})
	end,
}
