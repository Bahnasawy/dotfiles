return {
  "nvim-pack/nvim-spectre",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("spectre").setup {
      find_engine = {
        ["rg"] = {
          cmd = "rg",
          -- default args
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "-P",
          },
          options = {
            ["ignore-case"] = {
              value = "--ignore-case",
              icon = "[I]",
              desc = "ignore case",
            },
            ["hidden"] = {
              value = "--hidden",
              desc = "hidden file",
              icon = "[H]",
            },
            -- you can put any rg search option you want here it can toggle with
            -- show_option function
          },
        },
      },
    }
  end,
}
