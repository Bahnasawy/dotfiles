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
}
