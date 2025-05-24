{ pkgs, ... }:
{
  programs = {
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batman ];
    };
  };
  home.packages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    gh
    neovim
    kitty
    git
    zsh
    zoxide
    fzf
    lsd
    luarocks
    lua5_1
    nodejs_20
    tree-sitter
    gcc
    xclip
    zsh-prezto
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
    exercism
    cargo
    rustc
    rust-analyzer
    home-manager
    fd
    ghostty
    cowsay
    cmatrix
    ouch
    dwt1-shell-color-scripts
    ast-grep
    uv
    sqlite
    lua51Packages.jsregexp
    go
    zip
    icu.dev
    nixfmt-rfc-style
    nix-output-monitor
    yazi
    nixos-rebuild-ng
    python313
    moon
  ];
}
