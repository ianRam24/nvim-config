return {
  "EdenEast/nightfox.nvim",
  name = "nightfox",
  priority = 1000,
  transparent = true,
  config = function()
    require("nightfox").setup({
      options = {
        transparent = true,
      },
    })
    --		vim.cmd.colorscheme("nightfox")
  end,
}
