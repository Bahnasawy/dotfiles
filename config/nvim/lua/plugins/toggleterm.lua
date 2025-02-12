return {
  "akinsho/toggleterm.nvim",
  config = true,
  lazy = false,
  opts = {
    direction = "tab",
    autochdir = true,
  },
  keys = {
    { "<C-/>", ":ToggleTerm<cr>", desc = "ToggleTerm", silent = true },
  },
}
