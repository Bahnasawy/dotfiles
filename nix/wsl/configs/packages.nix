{pkgs, ...}: {
  programs.bat = {
    enable = true;
  };
  home.packages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    gh
    kitty
    git
    zsh
    zoxide
    fzf
    lsd
    luarocks
    nodejs_20
    tree-sitter
    gcc
    python3
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
    htop-vim
    exercism
    cargo
    rustc
    rust-analyzer
    home-manager
    bitwarden-cli
  ];
}
