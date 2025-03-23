{
  pkgs,
  config,
  lib,
  home,
  ...
}:
{
  home.packages = with pkgs; [
    mkalias
    iterm2
    postman
    git
    lazygit
    openssh
    zoxide
    fzf
    nodejs
    tree-sitter
    rustup
    raycast
    wget
    doppler
    gh
    nixd
    alejandra
    deadnix
    statix
    ripgrep
    cocoapods
    vscode
    discord
    sqlite
    luarocks
    lua5_1
    fd
    go
    htop
    android-tools
    ngrok
    dwt1-shell-color-scripts
    git-lfs
    ast-grep
    nixfmt-rfc-style
    uv
    postgresql
  ];

  home.sessionVariables = {
    LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.dylib";
  };

  programs = {
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batman ];
    };
    java = {
      enable = true;
      package = pkgs.openjdk17;
    };
    nushell = {
      enable = true;
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
        nano = "nvim";
      };

      configFile.source = config.lib.file.mkOutOfStoreSymlink ../../../config/nushell/config.nu;
    };

    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };

    zoxide.enable = true;
    zoxide.enableNushellIntegration = true;

    git = {
      enable = true;
      userEmail = "yousef.elbahnasawy@gmail.com";
      userName = "bahnasawy";
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      withPython3 = true;
      withNodeJs = true;
    };

    neovide = {
      enable = true;
      settings = {
        fork = false;
        frame = "full";
        idle = true;
        maximized = false;
        neovim-bin = pkgs.neovim.out;
        no-multigrid = false;
        srgb = false;
        tabs = true;
        theme = "auto";
        title-hidden = true;
        vsync = true;
        wsl = false;

        font = {
          normal = [ ];
          size = 14.0;
        };
      };
    };
  };

  # home.activation.uv = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
  #   (
  #     uv pythin install 3.14 --default --preview
  #   )
  # '';
}
