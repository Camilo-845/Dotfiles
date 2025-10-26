-- ~/.config/nvim/lua/plugins/copilot.lua
-- return { "github/copilot.vim",
--   event = "InsertEnter",
--   config = function()
--     vim.g.copilot_no_tab_map = true
--     vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
--   end,
-- }

return {
  -- Copilot backend
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp, -- falso si tienes copilot-cmp, así se desactiva el panel
        keymap = {
          accept = false, -- false porque lo maneja cmp
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
    },
  },

  -- Fuente para nvim-cmp
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
