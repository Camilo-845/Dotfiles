return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  },
  config = function()
    local dotnet = require("easy-dotnet")
    dotnet.setup({
      -- Leave your configuration hooks here
    })

    -- Correct keymaps for easy-dotnet
    vim.keymap.set("n", "<leader>dr", function() dotnet.run() end, { desc = ".NET Run" })
    -- Note: Standard debugging is typically initiated by standard DAP F5/Continue
    -- which triggers easy-dotnet's custom pickers automatically.
  end,
}
