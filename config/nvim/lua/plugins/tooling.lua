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
    keys = {
      { "<leader>gj", "<cmd>LazyJJ<CR>", { silent = true } },
    },
  },
  {
    "WilliamHsieh/overlook.nvim",
    opts = {},

    -- Optional: set up common keybindings
    keys = {
      {
        "<leader>pd",
        function()
          require("overlook.api").peek_definition()
        end,
        desc = "Overlook: Peek definition",
      },
      {
        "<leader>pc",
        function()
          require("overlook.api").close_all()
        end,
        desc = "Overlook: Close all popup",
      },
      {
        "<leader>pu",
        function()
          require("overlook.api").restore_popup()
        end,
        desc = "Overlook: Restore popup",
      },
    },
  },
}
