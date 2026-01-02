return {
  -- Typescript
  {
    "dmmulroy/tsc.nvim",
    ft = { "typescriptreact", "typescript" },
    opts = {
      run_as_monorepo = true,
      use_trouble_qflist = true,
    },
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
}
