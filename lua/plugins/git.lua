return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({})

      vim.keymap.set("n", "Gh", ":Gitsigns preview_hunk<CR>", { desc = "[G]it Preview Hun[K]" })
    end,
  },
  {
    "tpope/vim-fugitive",
  },
}
