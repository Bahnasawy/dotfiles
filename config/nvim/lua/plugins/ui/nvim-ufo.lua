return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "LspAttach",
  keys = {
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
      desc = "Open All Folds",
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
      desc = "Close All Folds",
    },
  },
  opts = {
    provider_selector = function()
      return { "lsp", "indent" }
    end,
    fold_virt_text_handler = function(virt_text, lnum, end_lnum, width, truncate)
      return require("ufo").get_fold_virt_text_handler(virt_text, lnum, end_lnum, width, truncate)
    end,
  },
}
