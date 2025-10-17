{
  config,
  pkgs,
  ...
}:
{
  system.activationScripts.applications.text =
    let
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
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';

  security.pam.services.sudo_local.touchIdAuth = true;

  system.primaryUser = "bahnasawy";
  system.defaults = {
    dock.autohide = true;
    dock.orientation = "left";
    dock.persistent-apps = [
      "/Applications/Arc.app"
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

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  users.users.bahnasawy.shell = pkgs.nushell;

  # Useful other development tools
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # start group of containers for dev
    nixfmt-rfc-style
    #podman-compose # start group of containers for dev
  ];

  services = {
    postgresql = {
      enable = true;
      # ensureDatabases = [ "gold-db" ];
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser      auth-method
        local all       all     trust
        host all       all     127.0.0.1/32 md5
      '';
      extraPlugins = with pkgs; [ postgresql14Packages.postgis ];
      dataDir = "/usr/local/var/postgres";
      package = pkgs.postgresql_14;
    };
  };
}
