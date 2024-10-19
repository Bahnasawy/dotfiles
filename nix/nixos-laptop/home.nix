{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./configs/packages.nix
    ./configs/plasma.nix
    ./configs/config.nix
  ];

  programs.home-manager.enable = true;

  home.username = "bahnasawy";
  home.homeDirectory = "/home/bahnasawy";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
