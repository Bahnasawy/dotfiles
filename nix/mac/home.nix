{
  config,
  pkgs,
  ...
}: {
  imports = [./configs/packages.nix];
  home.username = "bahnasawy";
  home.homeDirectory = "/Users/bahnasawy";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = [];

  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/nvim";
      recursive = true;
    };
    ".config/ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/ghostty";
      recursive = true;
    };
    ".config/gh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/gh";
      recursive = true;
    };
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/kitty";
      recursive = true;
    };
    ".config/neovide" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/neovide";
      recursive = true;
    };
    ".config/raycast" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/raycast";
      recursive = true;
    };
    ".zshrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/zshrc";
    };
    ".zpreztorc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/zpreztorc";
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  targets.darwin.currentHostDefaults."com.apple.controlcenter".BatteryShowPercentage = true;
}
