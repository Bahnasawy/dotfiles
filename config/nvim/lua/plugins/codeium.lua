return {
  "Exafunction/codeium.vim",
  commit = "289eb72",
  config = function()
    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set("i", "<M-l>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
    vim.keymap.set(
      "i",
      "<M-]>",
      function() return vim.fn["codeium#CycleCompletions"](1) end,
      { expr = true, silent = true }
    )
    vim.keymap.set(
      "i",
      "<M-[>",
      function() return vim.fn["codeium#CycleCompletions"](-1) end,
      { expr = true, silent = true }
    )
    vim.keymap.set("i", "<M-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })
  end,
}
