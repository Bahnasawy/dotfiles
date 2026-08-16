{
  pkgs,
  config,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    mkalias
    lazygit
    openssh
    zoxide
    fzf
    nodejs_24
    tree-sitter
    rustup
    wget
    doppler
    gh
    nixd
    alejandra
    deadnix
    statix
    ripgrep
    cocoapods
    sqlite
    luarocks
    lua5_1
    fd
    go
    htop
    ngrok
    dwt1-shell-color-scripts
    nixfmt
    uv
    ghostscript
    fastfetch
    btop
    cargo-cross
    bacon
    exercism
    zig
    tmux
    just
    lazydocker
    awscli2
    gitmux
    television
    sesh
    neovim
    postgresql
    jujutsu
    blazingjj
    curl
    herdr
    opencode
    tuicr
    atuin
  ];

  programs = {
    zsh = {
      enable = true;

      sessionVariables = {
        NIX_LDFLAGS = "${pkgs.libiconv}/lib";
        LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.dylib";
        ANDROID_HOME = "/Users/bahnasawy/.android/sdk";
        ANDROID_SDK_ROOT = "/Users/bahnasawy/.android/sdk";
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

    java = {
      enable = true;
      package = pkgs.openjdk17;
    };

    carapace.enable = true;

    starship = {
      enable = true;
      settings = {
        # "$schema" = "https://starship.rs/config-schema.json";
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };

    zoxide.enable = true;

    nh = {
      enable = true;
      flake = "/Users/bahnasawy/dotfiles/nix";
      clean = {
        enable = true;
      };
    };

    git = {
      enable = true;
      lfs = {
        enable = true;
      };
      includes = [
        {
          condition = "gitdir:~/fun/**";
          contents = {
            user.email = "yousef.elbahnasawy@gmail.com";
            core.sshCommand = "ssh -i ~/.ssh/personal";
          };
        }
        {
          condition = "gitdir:~/index/**";
          contents = {
            user.email = "yousef.elbahnasawy@indexinfotech.com";
            core.sshCommand = "ssh -i ~/.ssh/index";
          };
        }
      ];
      settings = {
        user.name = "Yousef Elbahnasawy";
      };
    };
  };
}
