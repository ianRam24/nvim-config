return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    -- Gain access to the dap plugin and its functions
    local dap = require("dap")
    -- Gain access to the dap ui plugin and its functions
    local dapui = require("dapui")
    local dap_virtual_text = require("nvim-dap-virtual-text")

    -- Setup the dap ui with default configuration
    dapui.setup({
      controls = {
        enabled = true,
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "↻",
          terminate = "□",
        },
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      force_buffers = true,
      icons = {
        collapsed = "",
        current_frame = "",
        expanded = "",
      },
      layouts = {
        {
          elements = {
            { id = "scopes",      size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks",      size = 0.25 },
            { id = "watches",     size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl",    size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 10,
          position = "bottom",
        },
      },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t",
      },
      render = {
        max_type_length = nil,
      },
    })

    dap_virtual_text.setup()

    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

    -- Setup an event listener for when the debugger is launched
    dap.listeners.before.launch.dapui_config = function()
      -- When the debugger is launched open up the debug ui
      dapui.open()
    end

    --    -- Keymaps
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebug toggle [B]reakpoint" })
    vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" })
    vim.keymap.set("n", "<leader>dq", dap.close, { desc = "[D]ebug [Q]uit" })

    -- User commands for command-line use
    vim.api.nvim_create_user_command('DebugToggleBreakpoint', function() dap.toggle_breakpoint() end, {})
    vim.api.nvim_create_user_command('DebugStart', function() dap.continue() end, {})
    vim.api.nvim_create_user_command('DebugClose', function() dapui.close() end, {})

    -- *** C++ / C / Rust configuration via codelldb ***
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebug toggle [B]reakpoint" })
    vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" })
    vim.keymap.set("n", "<leader>dq", dap.close, { desc = "[D]ebug [Q]uit" }) -- *** C++ / C / Rust configuration via codelldb ***


    dap.adapters.codelldb = function(callback, config)
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
      local adapter_path = mason_path .. "adapter/codelldb"
      local liblldb = mason_path .. "lldb/lib/liblldb.so" -- use .dylib on macOS
      callback({
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = adapter_path,
          args = { "--liblldb", liblldb, "--port", "${port}" },
        },
      })
    end

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
    }
    -- reuse for C and Rust
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp


    require("config.js-dap")
  end,
}
