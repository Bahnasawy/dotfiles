{ config, pkgs, ... }:
{
  home.username = "bahnasawy";
  home.homeDirectory = "/Users/bahnasawy";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
  ];
  home.file = {
    ".config" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/.config";
    };
    ".zshrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/.zshrc";
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  targets.darwin.currentHostDefaults."com.apple.controlcenter".BatteryShowPercentage = true;
}
