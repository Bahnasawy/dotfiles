{
  android-nixpkgs,
  config,
  ...
}:
{
  imports = [
    ./configs/packages.nix
    ./configs/dots.nix
    android-nixpkgs.hmModule
    {
      android-sdk.enable = true;

      # Optional; default path is "~/.local/share/android".
      android-sdk.path = "${config.home.homeDirectory}/.android/sdk";

      android-sdk.packages =
        sdk: with sdk; [
          build-tools-35-0-0
          build-tools-34-0-0
          cmdline-tools-latest
          emulator
          platforms-android-35
          platforms-android-34
          sources-android-35
          sources-android-34
          ndk-26-1-10909125
          ndk-27-1-12297006
          system-images-android-35-google-apis-arm64-v8a
          platform-tools
          cmake-3-22-1
        ];
    }
  ];
  home.username = "bahnasawy";
  home.homeDirectory = "/Users/bahnasawy";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  targets.darwin.currentHostDefaults."com.apple.controlcenter".BatteryShowPercentage = true;
}
