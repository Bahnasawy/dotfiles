return {
  "akinsho/toggleterm.nvim",
  opts = {
    shell = "/etc/profiles/per-user/bahnasawy/bin/nu",
  },
  keys = {
    { "<C-]>", "<cmd>ToggleTerm direction=tab<cr>", silent = true, desc = "Toggle floating terminal" },
  },
}
