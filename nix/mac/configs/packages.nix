{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    neovim
    mkalias
    zsh-prezto
    iterm2
    postman
    git
    lazygit
    openssh
    home-manager
    zoxide
    fzf
    nodejs_20
    tree-sitter
    rustup
    raycast
    lsd
    wget
    doppler
    gh
    nixd
    alejandra
    deadnix
    statix
    ripgrep
    cocoapods
    nodejs_20
    openjdk17
    vscode
    discord
    sqlite
    python313Packages.virtualenv
    luarocks
    lua5_1
    fd
    go
    htop
    android-tools
  ];

  programs.bat = {
    enable = true;
  };

  programs = {
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
    # zoxide.enableNushellIntegration = true;
  };
}
