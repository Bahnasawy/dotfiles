return {
  -- Typescript
  { "dmmulroy/ts-error-translator.nvim", lazy = true, ft = { "typescriptreact", "typescript" } },
  {
    "dmmulroy/tsc.nvim",
    ft = { "typescriptreact", "typescript" },
    opts = {
      run_as_monorepo = true,
      use_trouble_qflist = true,
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescriptreact", "typescript", "javascript" },
    opts = {},
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
  -- stylua: ignore
  keys = {
    { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
  },
    opts = {},
  },
  {
    "tpope/vim-dotenv",
  },
  -- {
  --   "olimorris/codecompanion.nvim",
  --   opts = {},
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  -- },
}
