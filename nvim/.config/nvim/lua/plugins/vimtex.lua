return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_compiler_method = "tectonic"
      vim.g.vimtex_compiler_callback = 0

      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_syntax_custom = {
        question = {
          environment = true,
        },
        answer = {
          environment = true,
        },
        solution = {
          environment = true,
        },
        problem = {
          environment = true,
        },
        lemma = {
          environment = true,
        },
        theorem = {
          environment = true,
        },
        corollary = {
          environment = true,
        },
        proposition = {
          environment = true,
        },
        definition = {
          environment = true,
        },
        example = {
          environment = true,
        },
        remark = {
          environment = true,
        },
        note = {
          environment = true,
        },
      }
    end,
    keys = {
      { "<leader>tl", "<cmd>VimtexCompile<cr>",       desc = "Compile LaTeX" },
      { "<leader>tk", "<cmd>VimtexCompileStop<cr>",   desc = "Stop compilation" },
      { "<leader>tc", "<cmd>VimtexClean<cr>",         desc = "Clean generated files" },
      { "<leader>tp", "<cmd>VimtexView<cr>",          desc = "View PDF" },
      { "<leader>tt", "<cmd>VimtexTocOpen<cr>",       desc = "Table of contents" },
      { "<leader>tr", "<cmd>VimtexView<cr>",    desc = "View PDF" },
      { "<leader>ts", "<cmd>VimtexStatus<cr>",        desc = "Compilation status" },
    },
    opts = {
      keymaps = {
        {
          mode = "n",
          prefix = "<localleader>",
          ["l"] = { "<cmd>VimtexCompile<cr>", desc = "Compile LaTeX" },
        },
      },
    },
  },
}
