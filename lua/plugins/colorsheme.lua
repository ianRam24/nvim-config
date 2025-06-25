return {
  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material", -- Add explicit name
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_enable_italic = true
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa", -- Add explicit name
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        theme = {
          wave = {
            ui = {
              float = {
                bg = "none",
              },
            },
          },
          dragon = {
            syn = {
            },
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            Parameter = { italic = true },
          }
        end,
        borderStyle = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
      })
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox", -- Add explicit name
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
        },
      })
    end,
  },
  {
    "sainnhe/sonokai",
    name = "sonokai", -- Add explicit name
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_enable_italic = true
      vim.g.sonokai_style = "andromeda"
    end,
  },
  {
    "sainnhe/everforest",
    name = "everforest", -- Add explicit name
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_enable_italic = true
      vim.g.everforest_background = "soft"
      vim.g.everforest_transparent_background = 1
    end,
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.moonflyTransparent = true
      vim.cmd.colorscheme("moonfly")
    end
  },

  {
    'sainnhe/edge',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.edge_enable_italic = true
      vim.g.edge_transparent_background = 1
      vim.cmd.colorscheme('edge')
    end
  }
}
