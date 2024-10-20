return {
  "stevearc/oil.nvim",

  dependencies = { { "echasnovski/mini.icons", opts = {} } },

  config = function(_, opts)
    require("oil").setup(opts)
    vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>")
  end,
}
