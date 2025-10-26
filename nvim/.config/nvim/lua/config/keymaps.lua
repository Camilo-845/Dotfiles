-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps hererocks
--

-- Toggle Term keymaps
vim.keymap.set("n", "<C-_>", "<cmd>ToggleTerm<cr>", { desc = "Open or Close ToggleTerm terminal" })
-- En modo terminal, usa Esc para salir del modo insert
--vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Salir del modo insert en terminal" })

-- Search and Replace keypmaps
-- Mapeo para buscar y reemplazar en todo el archivo
vim.api.nvim_set_keymap("n", "<leader>sr", [[:%s/]], { noremap = true, silent = true })
-- Mapeo para buscar y reemplazar en selección visual
vim.api.nvim_set_keymap("v", "<leader>sr", [[:s/]], { noremap = true, silent = true })
