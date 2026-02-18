-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("flutter-tools").setup {}
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })
vim.o.shell = "/bin/zsh"
require("toggleterm")
vim.opt.spell = false
