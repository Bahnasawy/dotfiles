return {
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    opts = function(_, opts)
      opts.debugger = { enabled = true }
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    specs = {
      -- Add "flutter" extension to "telescope"
      {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = function()
          require("telescope").load_extension("flutter")
        end,
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
  },
}
