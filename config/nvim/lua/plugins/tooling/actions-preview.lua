return {
  "aznhe21/actions-preview.nvim",
  lazy = true,
  keys = {
    {
      "gf",
      function()
        require("actions-preview").code_actions()
      end,
      mode = { "v", "n" },
      desc = "Action Preview",
    },
  },
}
