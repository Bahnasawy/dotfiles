return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  enabled = vim.fn.executable("fd") == 1 or vim.fn.executable("fdfind") == 1 or vim.fn.executable("fd-find") == 1,
  dependencies = {
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  opts = {},
  cmd = "VenvSelect",
}
