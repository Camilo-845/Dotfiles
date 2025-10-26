return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = 15,
    open_mapping = [[<C-_>]],
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    direction = "float", -- "horizontal", "vertical", "float", "tab"
    close_on_exit = true,
    shell = "/bin/zsh",
    highlights = {
      Normal = {
        -- aquí el fondo para el contenido de la terminal flotante
        guibg = "NONE", -- o el color de fondo que quieras (ejemplo: "#1a1b26" si usas tokyonight)
      },
      NormalFloat = {
        -- hacer link a Normal o poner color propio
        link = "Normal",
      },
      FloatBorder = {
        guifg = "#7aa2f7", -- color del borde
        guibg = "NONE", -- fondo del borde, o el color que quieras
      },
    },
    float_opts = {
      border = "curved",
    },
  },
  keys = {
    { "<leader>ft", "<cmd>ToggleTerm<cr>", desc = "ToggleTerm Terminal" },
  },
}
