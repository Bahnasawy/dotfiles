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
    google-chrome
    bluez
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
    # bitwarden-desktop
    bun
    filelight
    android-studio
    htop-vim
    jdk17
    neovide
    exercism
    cargo
    rustc
    rust-analyzer
    home-manager
  ];
}
