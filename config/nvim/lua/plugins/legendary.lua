return {
  "mrjones2014/legendary.nvim",
  -- since legendary.nvim handles all your keymaps/commands,
  -- its recommended to load legendary.nvim before other plugins
  priority = 1000000,
  lazy = false,
  -- sqlite is only needed if you want to use frecency sorting
  dependencies = { "kkharji/sqlite.lua" },
  opts = {
    extensions = { lazy_nvim = true },
    keymaps = {
      { "<Up>", { n = "<c-w>k" }, description = "Upper Split", opts = { remap = true } },
      { "<Down>", { n = "<c-w>j" }, description = "Lower Split", opts = { remap = true } },
      { "<Left>", { n = "<c-w>h" }, description = "Left Split", opts = { remap = true } },
      { "<Right>", { n = "<c-w>l" }, description = "Right Split", opts = { remap = true } },
    },
  },
}
