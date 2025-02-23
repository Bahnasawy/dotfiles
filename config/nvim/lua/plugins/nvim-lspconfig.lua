return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ---@type lspconfig.Config
      nixd = {
        cmd = { "nixd" },
        filetypes = { "nix" },
      },
    },
    setup = {
      nixd = function(_)
        if vim.loop.os_uname().sysname == "Linux" then
          require("lspconfig").nixd.setup({
            cmd = { "nixd" },
            settings = {
              nixd = {
                nixpkgs = {
                  expr = "import <nixpkgs> { }",
                },
                formatting = {
                  command = { "nixfmt" },
                },
                options = {
                  nixos = {
                    expr = "(builtins.getFlake (toString ./.)).nixosConfigurations." .. vim.fn.hostname() .. ".options",
                  },
                  home_manager = {
                    expr = "(builtins.getFlake (toString ./.)).homeConfigurations." .. vim.fn.hostname() .. ".options",
                  },
                },
              },
            },
          })
        else
          require("lspconfig").nixd.setup({
            cmd = { "nixd" },
            settings = {
              nixd = {
                nixpkgs = {
                  expr = "import <nixpkgs> { }",
                },
                formatting = {
                  command = { "nixfmt" },
                },
                options = {
                  nixdawin = {
                    expr = "(builtins.getFlake (toString ./.)).darwinConfigurations.mac.options",
                  },
                  home_manager = {
                    expr = "(builtins.getFlake (toString ./.)).homeConfigurations.mac.options",
                  },
                },
              },
            },
          })
        end
      end, -- or a custom handler function can be passed
    },
  },
}
