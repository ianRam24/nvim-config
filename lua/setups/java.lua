local springboot = require("springboot-nvim")

springboot.setup({})

vim.keymap.set("n", "<leader>Jr", springboot.boot_run, { desc = "Run Spring Boot" })
vim.keymap.set("n", "<leader>Jc", springboot.generate_class, { desc = "Java create class" })
vim.keymap.set("n", "<leader>Ji", springboot.generate_interface, { desc = "Java create interface" })
vim.keymap.set("n", "<leader>Je", springboot.generate_enum, { desc = "Java create enum" })
