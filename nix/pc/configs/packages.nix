{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    neovim
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    gh
    google-chrome
    git
    fzf
    lsd
    luarocks
    nodejs_20
    tree-sitter
    gcc
    python3
    xclip
    lazygit
    ripgrep
    unzip
    gnumake
    nixd
    alejandra
    deadnix
    statix
    doppler
    bun
    kdePackages.filelight
    jdk17
    exercism
    cargo
    rustc
    rust-analyzer
    lua5_1
    gzip
    zig
    ghostty
    neofetch
    nixfmt-rfc-style
    dwt1-shell-color-scripts
    sqlite
    gparted
    yazi
    protonup-qt
    umu-launcher
    wine
    go
    perl
    nix-output-monitor
    zsh
    fd
  ];

  home.sessionVariables = {
    LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.dylib";
  };

  programs = {
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batman ];
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

    plasma = {
      enable = true;
      workspace = {
        colorScheme = "BreezeDark";
        theme = "breeze-dark";
        lookAndFeel = "org.kde.breezedark.desktop";
      };
      input = {
        keyboard = {
          layouts = [
            {
              layout = "us";
            }
            {
              layout = "ar";
            }
          ];
        };
      };
      powerdevil.AC = {
        autoSuspend.action = "nothing";
        autoSuspend.idleTimeout = null;
        dimDisplay = {
          enable = false;
          idleTimeout = null;
        };
        powerButtonAction = "turnOffScreen";
        turnOffDisplay.idleTimeout = null;
      };
      krunner = {
        activateWhenTypingOnDesktop = true;
        position = "center";
      };
      workspace = {
        wallpaperPictureOfTheDay = {
          provider = "bing";
        };
        wallpaperFillMode = "preserveAspectCrop";
      };

      panels = [ ];

    };
  };
}
