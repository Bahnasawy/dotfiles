{
  config,
  pkgs,
  ...
}: {
  system.stateVersion = 5;

  system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
      name = "system-applications";
      paths = config.environment.systemPackages;
      pathsToLink = "/Applications";
    };
  in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock.autohide = true;
    dock.orientation = "left";
    dock.persistent-apps = [
      "/Applications/Arc.app"
      "${pkgs.neovide}/Applications/Neovide.app"
      "/System/Applications/Mail.app"
    ];
    finder.FXPreferredViewStyle = "clmv";
    finder.ShowPathbar = true;
    loginwindow.ShutDownDisabled = true;
    NSGlobalDomain.KeyRepeat = 2;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    loginwindow.GuestEnabled = true;
    dock.dashboard-in-overlay = false;
    dock.show-recents = false;
    dock.tilesize = 48;
    WindowManager.GloballyEnabled = true;
    NSGlobalDomain."com.apple.keyboard.fnState" = true;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    NSGlobalDomain."com.apple.trackpad.enableSecondaryClick" = true;
    trackpad.TrackpadRightClick = true;
    trackpad.Clicking = true;
  };

  programs.zsh.enable = true; # default shell on catalina

  services = {
    nix-daemon.enable = true;
  };
}
