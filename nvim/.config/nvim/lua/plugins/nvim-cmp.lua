return {
  -- Instala nvim-cmp y sus dependencias
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- Fuente LSP
      "hrsh7th/cmp-buffer",       -- Fuente para buffer
      "hrsh7th/cmp-path",         -- Fuente para rutas
      "saadparwaiz1/cmp_luasnip", -- Fuente para snippets
      "L3MON4D3/LuaSnip",         -- Sistema de snippets
    },
    config = function()
      -- Aquí configuramos nvim-cmp
      local cmp = require("cmp")
      print("mensaje")

      cmp.setup({
        -- Mapeos para cambiar las sugerencias con Tab
        mapping = {
          ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirmar la selección con Enter
          ["<C-Space>"] = cmp.mapping.complete(),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        formatting = {
          format = function(entry, vim_item)
            return vim_item
          end,
        },
      })
    end,
  },
}
