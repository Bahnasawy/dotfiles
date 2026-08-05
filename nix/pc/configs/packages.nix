{
  pkgs,
  config,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    inputs.purple.packages.${pkgs.system}.default
    neovim
    vim
    wget
    gh
    google-chrome
    git
    fzf
    lsd
    luarocks
    nodejs_26
    tree-sitter
    gcc
    python3
    wl-clipboard
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
    fastfetch
    nixfmt
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
    uv
    cairo
    pkgconf
    gobject-introspection
    gtk4
    python313Packages.evdev
    tmux
    devbox
    lazydocker
    imagemagick
    ghostscript
    poppler-utils
    firefox
    lsof
    lazydocker
    android-tools
    just
    mesa
    htop
    bridge-utils
    awscli2
    insomnia
    flutter
    lua51Packages.tiktoken_core
    lynx
    vscode
    transmission_4-qt6
    protontricks
    duckdb
    stremio-linux-shell
    catppuccin-kde
    vlc
    vlc-bittorrent
    lutris
    webkitgtk_6_0
    nix-index
    ulauncher
    television
    sesh
    wmctrl
    gvproxy
    netavark
    passt
    podman
    opencode
    teamviewer
    herdr
    tuicr
    libsecret
    anydesk
  ];

  home.sessionVariables = {
    LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.dylib";
  };

  programs = {
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batman ];
    };

    zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
    };

    nh = {
      enable = true;
      flake = "/home/bahnasawy/dotfiles/nix/pc";
      clean = {
        enable = true;
      };
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

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

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

    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };

    plasma = {
      workspace = {
        colorScheme = "Sweet";
        theme = "Sweet";
        lookAndFeel = "org.kde.breezedark.desktop";
      };
      input = {
        keyboard = {
          layouts = [
            {
              layout = "us";
            }
            {
              layout = "eg";
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
