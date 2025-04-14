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
    branch = "v2",
    -- commit = ""
    event = "VeryLazy",
    enabled = false,
    dependencies = {
      "chrisgrieser/nvim-spider",
      { "echasnovski/mini.test", version = false },
    },
    opts = {
      -- startVisible = true,
      -- showBlankVirtLine = true,
      -- highlightColor = { link = "Comment" },
      -- hints = {
      --      Caret = { text = "^", prio = 2 },
      --      Dollar = { text = "$", prio = 1 },
      --      MatchingPair = { text = "%", prio = 5 },
      --      Zero = { text = "0", prio = 1 },
      --      w = { text = "w", prio = 10 },
      --      b = { text = "b", prio = 9 },
      --      e = { text = "e", prio = 8 },
      --      W = { text = "W", prio = 7 },
      --      B = { text = "B", prio = 6 },
      --      E = { text = "E", prio = 5 },
      -- },
      -- gutterHints = {
      --     G = { text = "G", prio = 10 },
      --     gg = { text = "gg", prio = 9 },
      --     PrevParagraph = { text = "{", prio = 8 },
      --     NextParagraph = { text = "}", prio = 8 },
      -- },
      -- disabled_fts = {
      --     "startify",
      -- },
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
        { "<leader>/", LazyVim.pick("live_grep", { root = true }), desc = "Grep (cwd)" },
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
}
