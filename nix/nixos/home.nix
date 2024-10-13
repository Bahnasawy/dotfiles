{ config, pkgs, ... }:

{
  imports = [ ./packages.nix ];
  home.username = "bahnasawy";
  home.homeDirectory = "/home/bahnasawy";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.file.".config" = {
    source = ../../.config;
    recursive = true; # link recursively
  };

  home.file.".zshrc" = {
    source = ../../.zshrc;
  };

  home.file.".zpreztorc" = {
    source = ../../.zpreztorc;
  };


  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # home.packages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  #   neovim
  #   gh
  #   kitty
  #   google-chrome
  #   bluez
  #   git
  #   zsh
  #   zoxide
  #   fzf
  #   lsd
  #   luarocks
  #   nodejs_20
  #   tree-sitter
  #   gcc
  #   python3
  #   rustup
  #   xclip
  #   zsh-prezto
  # ];

  # Let Home Manager install and manage itself.
  programs. home-manager. enable = true;
}
