{
  config,
  lib,
  pkgs,
  ...
}: {
  i18n.defaultLocale = "en_US.UTF-8";

  nix = {
    enable = true;
    settings.max-jobs = 64;
  };

  system.stateVersion = "25.05";

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  programs = {
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      lua-language-server
      nodejs
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
    ];
  };
}
