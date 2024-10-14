{pkgs, ...}: {
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
    rustup
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
    bitwarden-desktop
    bun
    filelight
    #steam
    #proton-ge-bin
  ];
}
