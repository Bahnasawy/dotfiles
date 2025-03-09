return {
  "mfussenegger/nvim-treehopper",
  requires = "smoka7/hop.nvim",
  config = function()
    require("tsht").config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }
  end,
  keys = {
    { "M", ":<C-U>lua require('tsht').nodes()<CR>", mode = { "n", "o" } },
    { "M", ":lua require('tsht').nodes()<CR>", mode = { "n", "x" } },
  },
}
