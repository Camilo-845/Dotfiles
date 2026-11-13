return {
  "GustavEikaas/easy-dotnet.nvim",
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  },
  config = function()
    local dotnet = require("easy-dotnet")
    dotnet.setup({
      lsp = {
        preload_roslyn = false,
        restart_roslyn_on_branch_change = true,
        roslynator_enabled = false,
        auto_refresh_codelens = false,
        config = {
          settings = {
            ["csharp|code_lens"] = {
              dotnet_enable_references_code_lens = false,
              dotnet_enable_tests_code_lens = false,
            },
          },
        },
      }
    })

    -- Correct keymaps for easy-dotnet
    vim.keymap.set("n", "<leader>dr", function() dotnet.run() end, { desc = ".NET Run" })
    -- Note: Standard debugging is typically initiated by standard DAP F5/Continue
    -- which triggers easy-dotnet's custom pickers automatically.
  end,
}
