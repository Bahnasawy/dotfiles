return {
  { "folke/lazy.nvim", version = false },
  {
    "LazyVim/LazyVim",
    version = false,
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
  { import = "plugins.dev" },
  { import = "plugins.playground" },
  { import = "plugins.tooling" },
  { import = "plugins.ui" },
}
