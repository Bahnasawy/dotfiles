{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    inputs.purple.packages.${pkgs.system}.default
    (pkgs.callPackage ../pkgs/expo-orbit.nix { })
    neovim
    vim
    wget
    gh
    git
    fzf
    lsd
    luarocks
    tree-sitter
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
    kdePackages.filelight
    jdk17
    exercism
    cargo
    rustc
    rust-analyzer
    lua5_1
    gzip
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
    # android-tools
    ffmpeg # expo-device-hub encodes the emulator stream
    just
    mesa
    htop-vim
    bridge-utils
    awscli2
    lua51Packages.tiktoken_core
    transmission_4-qt
    protontricks
    duckdb
    stremio-linux-shell
    catppuccin-kde
    # Plasma rice (config lives in config/plasma, see docs/superpowers/specs)
    darkly
    plasma-panel-colorizer
    kde-rounded-corners
    application-title-bar
    (catppuccin-papirus-folders.override {
      flavor = "mocha";
      accent = "mauve";
    })
    catppuccin-cursors.mochaDark
    vlc
    vlc-bittorrent
    lutris
    webkitgtk_6_0
    nix-index
    television
    sesh
    wmctrl
    kdotool # query/manipulate KWin windows for desktop automation
    gvproxy
    netavark
    passt
    opencode
    teamviewer
    herdr
    tuicr
    libsecret
    anydesk
    atuin
    marksman
    mpv
    btop-rocm
    claude-code
    tuios
  ];

  home.sessionVariables = {
    LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.dylib";
  };

  programs = {
    mise = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;

      sessionVariables = {
        # ANDROID_HOME = "/home/bahnasawy/Android/sdk";
        # ANDROID_SDK_ROOT = "/home/bahnasawy/Android/sdk";
        # expo-device-hub streams emulators over gRPC; headless emulators skip it unless asked
        # EXPO_DEVICE_HUB_EMULATOR_EXTRA_ARGS = "-grpc 8554 -grpc-use-token";
        CROSS_CONTAINER_ENGINE = "podman";
        CROSS_CONTAINER_OPTS = "--platform=linux/amd64";
        NIX_PATH = "/home/bahnasawy/.nix-defexpr/channels:nixpkgs=flake:nixpkgs:/nix/var/nix/profiles/per-user/root/channels";
        BUN_INSTALL = "$HOME/.bun";
        PATH = "$HOME/.local/bin:$BUN_INSTALL/bin:$PATH";
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
        ls = "lsd";
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

          # Used by the Claude Code GitHub plugin's MCP server
          if command -v gh >/dev/null; then
            export GITHUB_PERSONAL_ACCESS_TOKEN="$(gh auth token 2>/dev/null)"
          fi
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

          herdr-lazy() {
            local root
            root=$(herdr plugin list --json | python3 -c \
              "import json,sys;print([p['plugin_root'] for p in json.load(sys.stdin)['result']['plugins'] if p['plugin_id']=='herdr-lazy'][0])")
            "$root/target/release/herdr-lazy" "$@"
          }

          eval "$(atuin init zsh)"
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
      flake = "/home/bahnasawy/dotfiles/nix";
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
        palette = "catppuccin_mocha";
        palettes.catppuccin_mocha = {
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
        };
      };
    };

    zoxide = {
      enable = true;
    };
  };
}
