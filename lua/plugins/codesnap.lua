return {
  {
    "mistricky/codesnap.nvim",
    lazy = true,
    build = "make",
    cmd = { "CodeSnapPreviewOn", "CodeSnapPreviewOff", "CodeSnap", "CodeSnapSave" },
    config = function()
      require("codesnap").setup({
        has_breadcrumbs = true,
        show_workspace = true,
        bg_color = "#535c68",
        bg_padding = 0,
      })
    end,
    keys = {
      { "<leader>cc", "<cmd>CodeSnap<cr>",     mode = "x", desc = "Save selected code snapshot into clipboard" },
      { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
    },
  },
}
