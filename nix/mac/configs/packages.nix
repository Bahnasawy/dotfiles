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
  ];

  programs = {
    zsh = {
      enable = true;

      sessionVariables = {
        NIX_LDFLAGS = "${pkgs.libiconv}/lib";
        LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.dylib";
      };

      shellAliases = {
        ld = "ld -L $NIX_LDFLAGS";
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

    nushell = {
      enable = true;
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
        nano = "nvim";
      };

      configFile.source = config.lib.file.mkOutOfStoreSymlink ../../../config/nushell/config.nu;

      extraConfig = ''
        $env.NIX_LDFLAGS = "${pkgs.libiconv}/lib"
        $env.LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.dylib"

        alias ld = ld -L $env.NIX_LDFLAGS
      '';
    };

    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
      enable = true;
      enableNushellIntegration = true;
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
    zoxide.enableNushellIntegration = true;

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
