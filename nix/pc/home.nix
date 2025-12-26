{
  config,
  android-nixpkgs,
  ...
}:
{
  imports = [
    ./configs/packages.nix
    ./configs/dots.nix
    # android-nixpkgs.hmModule
    # {
    #   android-sdk.enable = false;
    #
    #   # Optional; default path is "~/.local/share/android".
    #   android-sdk.path = "${config.home.homeDirectory}/.android/sdk";
    #
    #   android-sdk.packages =
    #     sdk: with sdk; [
    #       build-tools-35-0-0
    #       build-tools-34-0-0
    #       cmdline-tools-latest
    #       emulator
    #       platforms-android-35
    #       platforms-android-34
    #       sources-android-35
    #       sources-android-34
    #       ndk-26-1-10909125
    #       system-images-android-36-google-apis-x86-64
    #       platform-tools
    #       cmake-3-22-1
    #     ];
    # }
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
