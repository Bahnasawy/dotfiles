{
  config,
  lib,
  pkgs,
  # stdenv,
  ...
}:
let
  cfg = config.cromulent.services.podman;

  inherit (pkgs)
    qemu
    ;
  inherit (lib)
    mkEnableOption
    mkIf
    ;
in
{
  options.cromulent.services.podman = {
    enabled = mkEnableOption "Podman" // {
      default = true;
    };
  };

  config = mkIf cfg.enabled {
    environment = {
      systemPackages = [
        pkgs.podman
        qemu
        pkgs.xz
      ];

      # https://github.com/containers/podman/issues/17026
      pathsToLink = [ "/share/qemu" ];

      # https://github.com/LnL7/nix-darwin/issues/432#issuecomment-1024951660
      etc."containers/containers.conf.d/99-gvproxy-path.conf".text = ''
        [engine]
        helper_binaries_dir = ["${pkgs.gvproxy}/bin"]
      '';
    };
  };
}
