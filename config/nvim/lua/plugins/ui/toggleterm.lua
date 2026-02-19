return {
  "akinsho/toggleterm.nvim",
  config = true,
  lazy = false,
  opts = {
    direction = "tab",
    autochdir = true,
  },
  keys = {
    { "<C-]>", "<cmd>ToggleTerm<cr>", desc = "ToggleTerm", silent = true, remap = true, mode = { "n", "t" } },
  },
}
