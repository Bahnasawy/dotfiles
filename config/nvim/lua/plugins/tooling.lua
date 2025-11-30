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
  {
    "alex-popov-tech/store.nvim",
    dependencies = {
      "OXY2DEV/markview.nvim", -- optional, for pretty readme preview / help window
    },
    cmd = "Store",
    keys = {
      { "<leader>s", "<cmd>Store<cr>", desc = "Open Plugin Store" },
    },
    opts = {
      -- optional configuration here
    },
  },

  {
    "mistweaverco/kulala.nvim",
    config = function()
      -- Setup is required, even if you don't pass any options
      require("kulala").setup({})
    end,
  },
}
