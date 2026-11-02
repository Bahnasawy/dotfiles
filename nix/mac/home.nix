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

        # Matches React Native 0.88 / Expo SDK 58 (compileSdk 37, NDK 27.1)
        packages =
          sdk: with sdk; [
            build-tools-37-0-0
            build-tools-36-0-0
            cmdline-tools-latest
            emulator
            platforms-android-37-0
            ndk-27-1-12297006
            system-images-android-36-google-apis-arm64-v8a
            platform-tools
            cmake-3-22-1
          ];
      };
    }
  ];
  home = {
    username = "bahnasawy";
    homeDirectory = "/Users/bahnasawy";

    stateVersion = "26.05"; # Please read the comment before changing.

    sessionVariables = {
      EDITOR = "nvim";
      LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.dylib";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  targets.darwin.currentHostDefaults."com.apple.controlcenter".BatteryShowPercentage = true;
}
