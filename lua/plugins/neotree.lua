return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "echasnovski/mini.icons",        -- optional if you still want mini.icons
    "nvim-tree/nvim-web-devicons",   -- ← make sure this is listed here
  },
  config = function()
    -- you can also skip mini.icons entirely if you prefer web-devicons only
    require("neo-tree").setup({
      default_component_configs = {
        icon = {
          -- these glyphs will be looked up in web-devicons (or fall back to defaults)
          folder_closed = "",
          folder_open   = "",
          folder_empty  = "ﰊ",
          default       = "",
        },
      },
      filesystem = {
        filtered_items = {
          visible         = true,
          hide_dotfiles   = false,
          hide_gitignored = false,
          hide_hidden     = false,
        },
      },
      event_handlers = {
        {
          event   = "file_created",
          handler = function(args)
            if args.node.type == "file" then
              vim.cmd("edit " .. args.node.path)
              vim.cmd("Neotree close")
            end
          end,
        },
      },
    })
  end,
}
