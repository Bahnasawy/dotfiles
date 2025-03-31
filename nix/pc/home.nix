{
  config,
  android-nixpkgs,
  ...
}:
{
  imports = [
    ./configs/packages.nix
    ./configs/dots.nix
  ];

  programs = {
    home-manager.enable = true;
  };

  home.username = "bahnasawy";
  home.homeDirectory = "/home/bahnasawy";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
