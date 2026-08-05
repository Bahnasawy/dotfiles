{
  pkgs,
  config,
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
    zsh-syntax-highlighting
  ];

  programs = {
    zsh = {
      enable = true;

      sessionVariables = {
        NIX_LDFLAGS = "${pkgs.libiconv}/lib";
        LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.dylib";
        ZDOTDIR = "/Users/bahnasawy/.config/zsh";
      };
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
