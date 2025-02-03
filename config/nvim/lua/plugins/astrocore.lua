-- if true then return {} emd -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        neovide_input_macos_option_key_is_meta = "both",
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      n = {
        L = {
          function() require("astrocore.buffer").nav(vim.v.count1) end,
          desc = "Next buffer",
        },
        H = {
          function() require("astrocore.buffer").nav(-vim.v.count1) end,
          desc = "Previous buffer",
        },
        ["h"] = "hzz",
        ["j"] = "jzz",
        ["k"] = "kzz",
        ["l"] = "lzz",
        ["m"] = "x",
        ["<left>"] = "<C-w><left>",
        ["<right>"] = "<C-w><right>",
        ["<up>"] = "<C-w><up>",
        ["<down>"] = "<C-w><down>",
        ["<C-]>"] = {
          "<cmd>ToggleTerm direction=tab<cr>",
          silent = true,
          desc = "Toggle floating terminal",
        },
        ["<leader>D"] = {
          "<cmd>DBUI<cr>",
          silent = true,
          desc = "Open Dadbod UI",
        },
        ["<leader>tN"] = {
          "<cmd>tabnew<cr>",
          silent = true,
          desc = "Open a new tab",
        },
        ["<leader>fR"] = {
          "<cmd>Spectre<cr>",
          silent = true,
          desc = "Find and replace",
        },
        ["<Leader>c"] = {
          function()
            local bufs = vim.fn.getbufinfo { buflisted = 1 }
            require("astrocore.buffer").close(0)
            if not bufs[2] then require("snacks").dashboard.open() end
          end,
          desc = "Close buffer",
        },
        ["<leader>s"] = { name = "Simulators" },
        ["<leader>zd"] = { function() require("telescope").extensions.zoxide.list() end, desc = "Change directory" },
        ["<leader>si"] = {
          function() require("simulators.apple_simulator").open_simulator() end,
          desc = "Start ios simulator",
        },
        ["<leader>sa"] = {
          function() require("simulators.android_emulator").run() end,
          desc = "Start android simulator",
        },
        ["<leader>pn"] = {
          desc = "Node Package Info",
        },
        ["<leader>pns"] = {
          function() require("package-info").show { silent = true, noremap = true } end,
          desc = "Show package versions",
        },
        ["<leader>pnu"] = {
          function() require("package-info").update() end,
          desc = "Update package",
        },
        ["<leader>pnp"] = {
          function() require("package-info").change_version() end,
          desc = "Pick package version",
        },
        ["<leader>fn"] = {
          function() require("snacks").notifier.show_history() end,
          desc = "Show notification history",
        },
      },
      i = {
        ["<C-]>"] = {
          "<cmd>ToggleTerm direction=tab<cr>",
          silent = true,
          desc = "Toggle floating terminal",
        },
      },
      t = {
        ["<C-]>"] = {
          "<cmd>ToggleTerm direction=tab<cr>",
          silent = true,
          desc = "Toggle floating terminal",
        },
      },
    },
  },
}
