return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
  },
  config = function()
    require("tokyonight").setup({
      style = "night",  -- Ajusta el estilo del tema aquí
      transparent = true,  -- Habilitar la transparencia
    })
--    vim.cmd.colorscheme "tokyonight"
  end
}

