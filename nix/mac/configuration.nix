_: {
  imports = [
    ./configs/homebrew.nix
    ./configs/system.nix
  ];
  nix = {
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    enable = true;

    # Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";
    settings.max-substitution-jobs = 4;
    settings.http-connections = 8;
  };

  # Exported to launchd so GUI apps (e.g. Expo Orbit) see the Android SDK and AVDs.
  launchd.user.envVariables = {
    ANDROID_HOME = "/Users/bahnasawy/.android/sdk";
    ANDROID_AVD_HOME = "/Users/bahnasawy/.android/avd";
  };

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = false;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  nixpkgs = {
    # The platform the configuration will be used on.
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
  };
}
