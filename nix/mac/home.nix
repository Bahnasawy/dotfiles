{
  android-nixpkgs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./configs/packages.nix
    ./configs/dots.nix
    android-nixpkgs.hmModule
    {
      android-sdk = {
        enable = true;

        # Optional; default path is "~/.local/share/android".
        path = "${config.home.homeDirectory}/.android/sdk";

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
  home = {
    username = "bahnasawy";
    homeDirectory = "/Users/bahnasawy";

    stateVersion = "25.11"; # Please read the comment before changing.

    sessionVariables = {
      EDITOR = "nvim";
      LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.dylib";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  targets.darwin.currentHostDefaults."com.apple.controlcenter".BatteryShowPercentage = true;
}
