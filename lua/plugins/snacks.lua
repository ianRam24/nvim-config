return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
      styles = {
        input = {
          keys = {},
          n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
          i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
        },
      },

      input = { enabled = true },

      quickfile = {
        enabled = true,
        exclude = { "latex" },
      },

      picker = {
        enabled = true,
        matchers = {
          frecency = true,
          cwd_bonus = false,
        },
        formatters = {
          file = {
            filename_first = false,
            filename_only = false,
            icon_width = 2,
          },
        },
        layout = {
          preset = "telescope",
          cycle = false,
        },
        layouts = {
          select = {
            preview = false,
            layout = {
              backdrop = false,
              width = 0.6,
              min_width = 80,
              height = 0.4,
              min_height = 10,
              box = "vertical",
              border = "rounded",
              title = "{title}",
              title_pos = "center",
              { win = "input",   height = 1,          border = "bottom" },
              { win = "list",    border = "none" },
              { win = "preview", title = "{preview}", width = 0.6,      height = 0.4, border = "top" },
            },
          },
          telescope = {
            reverse = true,
            layout = {
              box = "horizontal",
              backdrop = false,
              width = 0.8,
              height = 0.9,
              border = "none",
              {
                box = "horizontal",
                { win = "preview", title = "{preview:Preview}", width = 0.5, border = "rounded", title_pos = "center" },
                {
                  box = "vertical",
                  { win = "list",  title = " Results ", title_pos = "center", border = "rounded" },
                  { win = "input", height = 1,          border = "rounded",   title = "{title} {live} {flags}", title_pos = "center" },
                },
              },
            },
          },
          ivy = {
            layout = {
              box = "vertical",
              backdrop = false,
              width = 0,
              height = 0.4,
              position = "bottom",
              border = "top",
              title = " {title} {live} {flags}",
              title_pos = "left",
              { win = "input", height = 1, border = "bottom" },
              {
                box = "horizontal",
                { win = "list",    border = "none" },
                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
              },
            },
          },
        },
      },

      image = {
        enabled = true,
        doc = {
          float = true,
          inline = false,
          max_width = 50,
          max_height = 30,
          wo = { wrap = false },
        },
        convert = {
          notify = true,
          command = "magick",
        },
        img_dirs = {
          "img", "images", "assets", "static", "public", "media", "attachments",
          "Archives/All-Vault-Images/", "~/Library", "~/Downloads"
        },
      },

      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys",   gap = 1, padding = 1 },
          { section = "startup" },
          {
            section = "terminal",
            random = 15,
            pane = 2,
            indent = 15,
            height = 20,
          },
        },
      },

      explorer = {
        enabled = true,
        -- Configuración alternativa más simple
        win = {
          position = "right",
          width = 30,
          height = 0,
          border = "rounded",
          title = "Explorer",
          title_pos = "center",
        },
        show_hidden = true,
        follow_file = true,
        indent = 2,
      },
    },

    config = function()
      -- No extra setup needed
    end,

    keys = {
      -- Pickers / Files
      { "<C-p>",           function() require("snacks").picker.files() end,                                   desc = "Find Files" },
      { "<leader><space>", function() require("snacks").picker.smart() end,                                   desc = "Smart Find Files" },
      { "<leader>pc",      function() require("snacks").picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ps",      function() require("snacks").picker.grep() end,                                    desc = "Grep Word" },
      { "<leader>pws",     function() require("snacks").picker.grep_word() end,                               desc = "Search Word or Selection",        mode = { "n", "x" } },
      { "<leader>pk",      function() require("snacks").picker.keymaps({ layout = "ivy" }) end,               desc = "Search Keymaps" },
      { "<leader>th",      function() require("snacks").picker.colorschemes({ layout = "ivy" }) end,          desc = "Pick Color Schemes" },
      { "<leader>vh",      function() require("snacks").picker.help() end,                                    desc = "Help Pages" },

      -- LSP
      { "gd",              function() require("snacks").picker.lsp_definitions() end,                         desc = "Goto Definition" },
      { "gD",              function() require("snacks").picker.lsp_declarations() end,                        desc = "Goto Declaration" },
      { "gI",              function() require("snacks").picker.lsp_implementations() end,                     desc = "Goto Implementation" },

      -- Git
      { "<leader>lg",      function() require("snacks").lazygit() end,                                        desc = "Lazygit" },
      { "<leader>gl",      function() require("snacks").lazygit.log() end,                                    desc = "Lazygit Logs" },
      { "<leader>gbr",     function() require("snacks").picker.git_branches({ layout = "select" }) end,       desc = "Git Branch Picker" },

      -- Buffers / File Management
      { "<leader>rN",      function() require("snacks").rename.rename_file() end,                             desc = "Fast Rename Current File" },
      { "<leader>dB",      function() require("snacks").bufdelete() end,                                      desc = "Delete or Close Buffer (Confirm)" },

      -- File Explorer
      { "<leader>e",       function() require("snacks").explorer() end,                                       desc = "File Explorer" },

      -- Terminal
      { "<leader>tt",      function() require("snacks").terminal() end,                                       desc = "Toggle Terminal" },
    },
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    optional = true,
    keys = {
      {
        "<leader>pt",
        function() require("snacks").picker.todo_comments() end,
        desc = "Todo",
      },
      {
        "<leader>pT",
        function()
          require("snacks").picker.todo_comments({
            keywords = { "TODO", "FIX", "FIXME" }
          })
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },
}
