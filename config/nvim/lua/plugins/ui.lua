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
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = {
      {
        "chrisgrieser/nvim-spider",
        commit = "871b019cecced368abc575de039406d08acc3299",
        opts = {},
        lazy = true,
        keys = {
          { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
          { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
          { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
        },
      },
    },
  },
  {
    "mcauley-penney/visual-whitespace.nvim",
    config = true,
    keys = {
      "v",
      "V",
      "<C-v>",
    },
  },
  {
    "rachartier/tiny-glimmer.nvim",
    event = "TextYankPost",
    lazy = false,
    priority = 10,
    enabled = false,
    opts = {
      overwrite = {
        yank = {
          default_animation = "pulse",
        },
        undo = {
          enable = true,
        },
        redo = {
          enable = true,
        },
      },
      presets = {
        pulsar = {
          enabled = true,
          default_animation = {
            name = "pulse",
          },
        },
      },
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
  },
  {
    {
      "folke/snacks.nvim",
      --- @type snacks.Config
      opts = {
        dashboard = {
          enabled = true,
          sections = {
            { section = "header" },
            {
              pane = 2,
              section = "terminal",
              cmd = "colorscript -e square",
              height = 5,
              padding = 1,
            },
            { section = "keys", gap = 1, padding = 1 },
            { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
            { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
            {
              pane = 2,
              icon = " ",
              title = "Git Status",
              section = "terminal",
              enabled = function()
                return Snacks.git.get_root() ~= nil
              end,
              cmd = "git status --short --branch --renames",
              height = 5,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            },
            { section = "startup" },
          },
        },
      },
      keys = {
        { "<leader>zd", require("snacks").picker.zoxide, { desc = "Open LazyGit" } },
      },
    },
  },
  {
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
  },
  {
    "OXY2DEV/helpview.nvim",
    lazy = false,
    opts = {
      preview = {
        icon_provider = "devicons",
      },
    },
  },
}
