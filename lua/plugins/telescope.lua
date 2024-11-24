return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "andrew-george/telescope-themes",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      -- Load extensions
      telescope.load_extension("ui-select")
      telescope.load_extension("themes")

      -- Telescope setup
      telescope.setup({
        defaults = {
          path_display = { "smart" },
          layout_config = {
            horizontal = { preview_cutoff = 0 },
          },
        },
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          themes = {
            enable_previewer = true,
            enable_live_preview = false,
            persist = {
              enabled = true,
              -- This path should point to a file that will store the current theme selection
              path = vim.fn.stdpath("config") .. "/lua/current-theme.lua",
            },
          },
        },
      })

      -- Keybindings
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

      -- Theme switcher keybinding
      vim.keymap.set(
        "n",
        "<leader>th",
        ":Telescope themes<CR>",
        { noremap = true, silent = true, desc = "Theme Switcher" }
      )
    end,
  },
}
