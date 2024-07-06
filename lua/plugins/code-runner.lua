return {
  "CRAG666/code_runner.nvim",
  config = function()
    require('code_runner').setup({
      filetype = {
        java = {
          "cd $dir &&",
          " $fileName &&",
          "java $fileNameWithoutExt"
        },
        python = "python3 -u",
        typescript = "deno run",
        rust = {
          "cd $dir &&",
          "rustc $fileName &&",
          "$dir/$fileNameWithoutExt"
        },
        c = function()
          local c_base = {
            "cd $dir &&",
            "gcc $fileName -o",
            "/tmp/$fileNameWithoutExt",
          }
          local c_exec = {
            "&& /tmp/$fileNameWithoutExt &&",
            "rm /tmp/$fileNameWithoutExt",
          }
          vim.ui.input({ prompt = "Add more args:" }, function(input)
            c_base[4] = input
            require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
          end)
        end,
        springboot = {
          "cd $dir &&",
          "mvn spring-boot:run"
        },
        javascript = "node $fileName",
      },
      mode = "float",
      float = {
        border = "rounded",
        width = 80,
        height = 30,
        winblend = 3,
        anchor = "NW",
        relative = "editor",
        row = math.floor((vim.o.lines - 30) / 2),   -- Centrado verticalmente (ajusta según el tamaño de la ventana flotante)
        col = math.floor((vim.o.columns - 80) / 2),   -- Centrado horizontalmente (ajusta según el tamaño de la ventana flotante)
      }
    })

    vim.keymap.set('n', '<C-r>', ':RunCode <CR>', { noremap = true, silent = false })
  end,
}
