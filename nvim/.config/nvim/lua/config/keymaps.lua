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

-- Buffer: navigate open-buffer history (back/forward), only tracking real file buffers
local buf_history = {}
local buf_history_index = 0
local buf_history_navigating = false

local function buf_history_is_tracked(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return false
  end
  -- skip unlisted buffers (floats, pickers, dashboard) and special buffers (terminal, quickfix, help, ...)
  if not vim.bo[buf].buflisted then
    return false
  end
  if vim.bo[buf].buftype ~= "" then
    return false
  end
  return true
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if buf_history_navigating then
      return
    end
    local buf = vim.api.nvim_get_current_buf()
    if not buf_history_is_tracked(buf) then
      return
    end
    if buf_history[buf_history_index] ~= buf then
      for i = #buf_history, buf_history_index + 1, -1 do
        buf_history[i] = nil
      end
      buf_history_index = buf_history_index + 1
      buf_history[buf_history_index] = buf
    end
  end,
})

local function buf_history_jump_to(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return false
  end
  buf_history_navigating = true
  vim.api.nvim_set_current_buf(buf)
  buf_history_navigating = false
  return true
end

local function buf_history_back()
  while buf_history_index > 1 do
    buf_history_index = buf_history_index - 1
    if buf_history_jump_to(buf_history[buf_history_index]) then
      return
    end
  end
end

local function buf_history_forward()
  while buf_history_index < #buf_history do
    buf_history_index = buf_history_index + 1
    if buf_history_jump_to(buf_history[buf_history_index]) then
      return
    end
  end
end

vim.keymap.set("n", "<S-h>", buf_history_back, { desc = "Prev Buffer (history)" })
vim.keymap.set("n", "<S-l>", buf_history_forward, { desc = "Next Buffer (history)" })
