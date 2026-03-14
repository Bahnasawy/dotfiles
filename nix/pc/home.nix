{ config, android-nixpkgs, ... }:
{
  imports = [
    ./configs/packages.nix
    ./configs/dots.nix
    android-nixpkgs.hmModule
    {
      android-sdk = {
        enable = true;

        # Optional; default path is "~/.local/share/android".
        path = "${config.home.homeDirectory}/Android/sdk";

        packages =
          sdk: with sdk; [
            build-tools-35-0-0
            build-tools-34-0-0
            build-tools-36-0-0
            cmdline-tools-latest
            emulator
            platforms-android-36
            platforms-android-35
            platforms-android-34
            platforms-android-33
            platforms-android-32
            sources-android-36
            sources-android-35
            sources-android-34
            ndk-26-1-10909125
            ndk-28-2-13676358
            ndk-27-1-12297006
            system-images-android-36-google-apis-x86-64
            platform-tools
            cmake-3-22-1
          ];
      };
    }
  ];

  programs = {
    home-manager.enable = true;
  };
  home = {
    username = "bahnasawy";
    homeDirectory = "/home/bahnasawy";

    stateVersion = "25.11"; # Please read the comment before changing.

    sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
