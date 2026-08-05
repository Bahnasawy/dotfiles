{
  config,
  pkgs,
  ...
}:
{
  system = {
    activationScripts.applications.text =
      let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = [ "/Applications" ];
        };
      in
      pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
      '';

    defaults = {
      dock = {
        autohide = true;
        orientation = "left";
        persistent-apps = [
          "/Applications/Arc.app"
        ];
      };
      finder.FXPreferredViewStyle = "clmv";
      finder.ShowPathbar = true;
      loginwindow.ShutDownDisabled = true;
      NSGlobalDomain = {
        KeyRepeat = 2;
        AppleInterfaceStyle = "Dark";
        "com.apple.keyboard.fnState" = true;
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.trackpad.enableSecondaryClick" = true;
      };
      loginwindow.GuestEnabled = true;
      dock.dashboard-in-overlay = false;
      dock.show-recents = false;
      dock.tilesize = 48;
      WindowManager.GloballyEnabled = true;
      trackpad.TrackpadRightClick = true;
      trackpad.Clicking = true;
    };

    primaryUser = "bahnasawy";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.zsh.enable = true; # default shell on catalina

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  users.users.bahnasawy.shell = pkgs.zsh;

  environment = {
    systemPackages = with pkgs; [
      dive # look into docker image layers
      docker-compose # start group of containers for dev
    ];

    etc."pam.d/sudo_local".text = ''
      # Managed by Nix Darwin
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
      auth       sufficient     pam_tid.so
    '';
  };
}
