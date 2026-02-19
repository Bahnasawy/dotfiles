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
    nodejs
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
    ast-grep
    nixfmt
    uv
    ghostscript
    neofetch
    btop
    yazi
    cargo-cross
    python313
    bacon
    exercism
    moon
    zig
    tmux
    devbox
    vscode
    just
    lazydocker
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

    neovim = {
      enable = true;
      defaultEditor = true;
      withPython3 = true;
      withNodeJs = true;
      viAlias = true;
      vimAlias = true;
    };

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
    };
  };
}
