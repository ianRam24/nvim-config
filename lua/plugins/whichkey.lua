return {
  "folke/which-key.nvim",
  event = "VimEnter",
  config = function()
    local which_key = require("which-key")

    which_key.setup({})

    -- Leader key mappings
    which_key.register({
      ["/"] = { ":CommentToggle<CR>", "Toggle Comments" },

      C = {
        name = "[C]sharp",
        a = { ":lua require('csharp').fix_all()<CR>", "Fix All" },
        r = { ":lua require('csharp').run_project()<CR>", "Run Project" },
        s = { ":lua require('csharp').view_user_secrets()<CR>", "View User Secrets" },
        u = { ":lua require('csharp').fix_usings()<CR>", "Fix Usings" },
      },

      J = {
        name = "[J]ava",
        b = { ":JBuild<CR>", "Build Java" },
        r = { ":JRun<CR>", "Run Java" },
      },

      c = {
        name = "[C]ode",
        a = { ":lua vim.lsp.buf.code_action()<CR>", "Code Action" },
        f = { ":lua vim.lsp.buf.formatting()<CR>", "Format Code" },
      },

      d = {
        name = "[D]ebug",
        b = { ":DebugToggleBreakpoint<CR>", "Toggle Breakpoint" },
        c = { ":DebugContinue<CR>", "Continue Debugging" },
      },


      G = {
        name = "[G]it",
        A = { ":Git add .<CR>", "Add [A]ll" },
        a = { ":Git add %<CR>", "Add Current File" },
        B = { ":Git blame<CR>", "[B]lame" },
        C = { ":Git commit<CR>", "[C]ommit" },
        P = { ":Git push<CR>", "[P]ush" },
        h = { ":Gitsigns preview_hunk<CR>", "Preview [H]unk" },
      },

      t = {
        name = "[T]est",
        r = { ":TestRun<CR>", "Run Tests" },
      },

      w = {
        name = "[W]indow",
        s = { ":split<CR>", "Horizontal Split" },
        v = { ":vsplit<CR>", "Vertical Split" },
      },
    }, { prefix = "<leader>" })

    -- Ctrl mappings (fixed format)
    which_key.register({
      ["<C-a>"] = { ":lua require('csharp').fix_all()<CR>", "Fix All" },
      ["<C-r>"] = { ":lua require('csharp').run_project()<CR>", "Run Project" },
      ["<C-s>"] = { ":lua require('csharp').view_user_secrets()<CR>", "View User Secrets" },
      ["<C-u>"] = { ":lua require('csharp').fix_usings()<CR>", "Fix Usings" },
    })
  end,
}
