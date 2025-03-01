return {
  {
    "smoka7/hop.nvim",
    opts = {},
    lazy = true,
    keys = {
      {
        "`",
        function()
          require("hop").hint_words()
        end,
        mode = { "n" },
        desc = "Hop hint words",
      },
      {
        "~",
        function()
          require("hop").hint_lines()
        end,
        mode = { "n" },
        desc = "Hop hint lines",
      },
      {
        "`",
        function()
          require("hop").hint_words({ extend_visual = true })
        end,
        mode = { "v" },
        desc = "Hop hint words",
      },
      {
        "~",
        function()
          require("hop").hint_lines({ extend_visual = true })
        end,
        mode = { "v" },
        desc = "Hop hint lines",
      },
    },
  },
}
