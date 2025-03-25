return {
  { "rebelot/kanagawa.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = {
    term_colors = true,
  } },
}
