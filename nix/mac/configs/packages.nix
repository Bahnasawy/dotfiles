{
  pkgs,
  config,
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
    ngrok
    dwt1-shell-color-scripts
    git-lfs
    ast-grep
    nixfmt-rfc-style
    uv
    postgresql
    ghostscript
    neofetch
    btop
    yazi
    cargo-cross
    pkgsCross.mingwW64.buildPackages.gcc
    pkgsCross.mingwW64.stdenv.cc
    pkgsCross.mingwW64.windows.pthreads
    gcc
    bacon
    uv
    python313
    git
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
    };
  };
}
