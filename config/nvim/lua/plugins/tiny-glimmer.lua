return {
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
}
