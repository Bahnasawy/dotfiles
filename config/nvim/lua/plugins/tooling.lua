return {
  {
    "mrjones2014/legendary.nvim",
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 1000000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    dependencies = { "kkharji/sqlite.lua" },
    opts = {},
  },
  {
    "gbprod/yanky.nvim",
    lazy = true,
  },
  {
    "swaits/lazyjj.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },
}
