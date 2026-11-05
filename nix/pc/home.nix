{
  config,
  inputs,
  pkgs,
  ...
}:
let
  # The SDK's bundled ninja is statically linked; autoPatchelf gives it an
  # interpreter anyway and it segfaults on start. Swap in nixpkgs' ninja.
  withNixNinja =
    cmake:
    cmake.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        ln -sf ${pkgs.ninja}/bin/ninja $out/bin/ninja
      '';
    });
in
{
  imports = [
    # inputs.nix-openclaw.homeManagerModules.openclaw
    # ./openclaw
    inputs.zen-browser.homeModules.twilight-official
    ./configs/packages.nix
    ./configs/dots.nix
    inputs.android-nixpkgs.hmModule
    {
      android-sdk = {
        enable = true;

        # Optional; default path is "~/.local/share/android".
        path = "${config.home.homeDirectory}/Android/sdk";

        packages =
          sdk: with sdk; [
            build-tools-35-0-0
            build-tools-36-0-0
            build-tools-37-0-0
            # 20+ wrap the Android CLI, which writes .sdk into the read-only SDK
            # and crashes `sdkmanager --list_installed`; tools expect it at latest/.
            (cmdline-tools-19-0 // { path = "cmdline-tools/latest"; })
            emulator
            platforms-android-36
            platforms-android-37-0
            sources-android-36
            ndk-27-1-12297006
            platform-tools
            (withNixNinja cmake-3-22-1)
            (withNixNinja cmake-3-30-5)
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
