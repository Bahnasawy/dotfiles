{
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.twilight-official
    ./configs/packages.nix
    ./configs/dots.nix
    inputs.android-nixpkgs.hmModule
    {
      android-sdk = {
        enable = false;

        # Optional; default path is "~/.local/share/android".
        path = "${config.home.homeDirectory}/Android/sdk";

        packages =
          sdk: with sdk; [
            build-tools-35-0-0
            build-tools-36-0-0
            cmdline-tools-latest
            emulator
            platforms-android-36
            sources-android-36
            ndk-27-1-12297006
            ndk-28-2-13676358
            platform-tools
            cmake-3-22-1
            system-images-android-36-google-apis-x86-64
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

    stateVersion = "26.11"; # Please read the comment before changing.

    sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
