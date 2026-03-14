return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerOpen",
    "OverseerClose",
    "OverseerToggle",
    "OverseerShell",
    "OverseerRun",
    "OverseerTaskAction",
  },
  specs = {
    {
      "catppuccin",
      optional = true,
      opts = { integrations = { overseer = true } },
    },
  },
  keys = {
    { "<leader>or", ":OverseerRun<cr>", desc = "Overseer Run", silent = true },
    { "<leader>ot", ":OverseerToggle<cr>", desc = "Overseer Toggle", silent = true },
  },
}
