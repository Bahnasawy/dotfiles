return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- optional but recommended
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  {
    "dimaportenko/telescope-simulators.nvim",
    lazy = false,
    config = function()
      require("simulators").setup({
        android_emulator = true,
        apple_simulator = false,
      })
    end,
    keys = {
      {
        "<leader>t",
        ":Telescope simulators run<cr>",
        silent = true,
        remap = true,
        desc = "Run simulator",
      },
    },
  },
}
