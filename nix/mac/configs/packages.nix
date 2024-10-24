{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    mkalias
    zsh-prezto
    iterm2
    postman
    bun
    git
    lazygit
    openssh
    home-manager
    zoxide
    fzf
    nodejs_20
    tree-sitter
    rustup
    neovide
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
  ];
}
