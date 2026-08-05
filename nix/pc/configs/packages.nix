{
  pkgs,
  config,
  lib,
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
    zsh = {
      enable = true;

      sessionVariables = {
        ANDROID_HOME = "/home/bahnasawy/Android/sdk";
        ANDROID_SDK_ROOT = "/home/bahnasawy/Android/sdk";
        CROSS_CONTAINER_ENGINE = "podman";
        CROSS_CONTAINER_OPTS = "--platform=linux/amd64";
        NIX_PATH = "/Users/bahnasawy/.nix-defexpr/channels:nixpkgs=flake:nixpkgs:/nix/var/nix/profiles/per-user/root/channels";
      };

      defaultKeymap = "viins";

      setOptions = [
        "MENUCOMPLETE"
        "COMPLETE_IN_WORD"
      ];

      autosuggestion.enable = true;

      enableCompletion = true;

      syntaxHighlighting.enable = true;

      shellAliases = {
        man = "batman";
        cd = "z";
        vi = "nvim";
      };

      initContent = lib.mkMerge [
        (lib.mkOrder 550 ''
          zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
          zstyle ':completion:*' menu select
          zstyle ':completion:*' max-results 100
          zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        '')

        (lib.mkOrder 700 ''
          export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
        '')

        (lib.mkOrder 1000 ''
          if [[ -n "$NIX_LDFLAGS" ]]; then
            alias ld='ld -L $NIX_LDFLAGS'
          fi

          db() {
            if [[ "$(uname)" == "Darwin" ]]; then
              nh darwin switch "$HOME/dotfiles/nix" -H mac "$@"
            else
              nh os switch "$HOME/dotfiles/nix" -H "$(hostname)" "$@"
            fi
          }

          collect-garbage() {
            nh clean all
          }

          fu() {
            if [[ "$(uname)" == "Darwin" ]]; then
              nix flake update --flake "$HOME/dotfiles/nix"
            else
              sudo nix flake update --flake "$HOME/dotfiles/nix"
            fi
          }

          dev() {
            if command ls | command grep -q bun; then
              bun run dev "$@"
            fi
          }

          clone-index-repo() {
            gh repo clone "Index-Infotech/$1" -- -c core.sshCommand="ssh -i ~/.ssh/index"
          }
        '')
      ];
    };

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

    carapace = {
      enable = true;
    };

    starship = {
      enable = true;
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
