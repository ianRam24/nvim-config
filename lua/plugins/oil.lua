return {
  "stevearc/oil.nvim",
  dependencies = {
    "echasnovski/mini.icons",        -- optional
    "nvim-tree/nvim-web-devicons",   -- ← ensure devicons is available
  },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      use_devicons          = true,      -- ← turn on icons
      view_options          = {
        show_hidden = true,
      },
      keymaps               = {
        ["<M-h>"] = "actions.select_split",
        ["q"]     = "actions.close",
      },
    })

    -- open parent dir in normal & float
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Toggle Oil float" })
  end,
}
