{pkgs, ...}: {
  programs.bat = {
    enable = true;
  };
  home.packages = with pkgs; [
    neovim
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    gh
    kitty
    google-chrome
    bluez
    git
    fzf
    lsd
    luarocks
    nodejs_20
    tree-sitter
    gcc
    python3
    xclip
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
    kdePackages.filelight
    android-studio
    htop-vim
    jdk17
    neovide
    exercism
    cargo
    rustc
    rust-analyzer
    home-manager
    lsof
    killall
    bitwarden-cli
    beekeeper-studio
    pnpm
    lua5_1
    gzip
    zig
    ghostty
    neofetch
    bitwarden-desktop
  ];
}
