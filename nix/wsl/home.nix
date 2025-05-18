{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./configs/packages.nix
    ./configs/config.nix
  ];

  programs.home-manager.enable = true;

  home.username = "bahnasawy";
  home.homeDirectory = "/home/bahnasawy";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
