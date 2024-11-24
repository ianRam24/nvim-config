return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  config = function()
    local noice = require("noice")
    -- Dismiss notification after 3 seconds and create command to close
    noice.setup({
      notify = {
      timeout = 1000, -- 3 seconds
      },
    })

    -- Create a keymap to close notifications with <leader>nd
    vim.api.nvim_set_keymap('n', '<leader>nd', ':NoiceDismiss<CR>', { noremap = true, silent = true })

  end,
}
